# Reads the GitLab token from the macOS login Keychain (no plaintext on disk).
# Create the item once with:
#   security add-generic-password -a $USER -s gitlab-token -w <your-token>
# Looks up by service name only, so it is independent of the macOS username.
function gitlab_token
    security find-generic-password -s gitlab-token -w
end
