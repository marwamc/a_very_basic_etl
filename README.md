### A very basic etl



### How to run:
In this project (peg_etl) directory, run the following commands:

    1)  ./run build
    2)  ./run setup
    3)  ./run db
    

#### Docker cleanup
  docker rm -vf $(docker ps -a -q)
  docker rmi -f $(docker images -a -q)

