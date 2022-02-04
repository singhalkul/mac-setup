#!/bin/sh

brew list | grep oracle-jdk >/dev/null

if test $? -eq 0; then
  echo ">>> Setting up symlink for Oracle JDK17"
  jenv add /Library/Java/JavaVirtualMachines/jdk-17.0.2.jdk/Contents/Home
fi

brew list | grep adoptopenjdk11 >/dev/null

if test $? -eq 0; then
  echo ">>> Setting up symlink for AdoptOpen JDK11"
  jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
fi

