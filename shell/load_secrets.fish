# Load secret credentials from the macOS login Keychain into the current shell.
#
# Credentials are stored under the "mac-setup" service, keyed by env-var name:
#   security add-generic-password -s mac-setup -a <NAME> -w '<value>' -U
#
# Non-secret work config (AWS_PROFILE, KOPS_STATE_STORE, Cypress usernames and
# Auth0 domain/audience/client-id) lives directly in conf.d/secrets.fish and is
# set at shell startup. Only real credentials go through the Keychain, on demand.
function load-secrets --description 'Load Keychain-stored secrets into this shell'
    set -l names \
        CYPRESS_MP_SERVICE_MANAGER_PWD CYPRESS_AUTH0_CLIENT_SECRET \
        CYPRESS_MP_ADMIN_PWD
    set -l missing
    for name in $names
        set -l val (security find-generic-password -s mac-setup -a $name -w 2>/dev/null)
        if test -n "$val"
            set -gx $name $val
        else
            set -a missing $name
        end
    end
    if test (count $missing) -gt 0
        echo "load-secrets: not found in Keychain: $missing" >&2
        echo "  store with: security add-generic-password -s mac-setup -a <NAME> -w '<value>' -U" >&2
        return 1
    end
    echo "Loaded "(count $names)" secrets from Keychain into this shell."
end
