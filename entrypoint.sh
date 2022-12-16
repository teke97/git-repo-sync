mkdir -p ~/.ssh
cat > ~/.ssh/config <<-EOF
host 
 Hostname ${INPUT_TARGET_SSH_HOST}
 IdentityFile id_rsa
 User git
EOF

echo "$INPUT_TARGET_SSH_KEY" > id_rsa
chmod 600 id_rsa

git remote add target ${INPUT_TARGET_URL}

case "${GITHUB_EVENT_NAME}" in
    push)
        git push -f --all target
        git push -f --tags target
        ;;
    delete)
        git push -d target ${GITHUB_EVENT_REF}
        ;;
    *)
        break
        ;;
esac