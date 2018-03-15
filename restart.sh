cd $(dirname $0)
echo '========== stop kongTest ========='
docker-compose stop kongTest

echo '========== start kongTest ========'
docker-compose up -d
