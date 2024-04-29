docker-compose -f grid.yaml up --scale chrome=2 -d

set BROWSER=chrome
set TEST_SUITE=vendor-portal.xml

docker-compose -f test-suites.yaml up

docker-compose -f grid.yaml up --scale firefox=2 -d

set BROWSER=firefox
set TEST_SUITE=vendor-portal.xml

docker-compose -f test-suites.yaml up

docker-compose -f grid.yaml down
docker-compose -f test-suites.yaml down