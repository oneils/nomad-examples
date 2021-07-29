job "mongodb" {
    datacenters = ["dc1"]

    group "mongodb" {
        count = 1 

        restart {
            attempts = 10
            interval = "5m"
            delay = "25s"
            mode = "delay"
        }

        update {
            max_parallel     = 1
            min_healthy_time = "30s"
            healthy_deadline = "5m"
        }
        

        task  "mongodb" {
            driver = "docker"

            config {
                image = "mongo:4.4.6"
            port_map {
                db = 27017
                }
            }

            env {
                MONGO_INITDB_ROOT_USERNAME = "root"
                MONGO_INITDB_ROOT_PASSWORD="root"
            }

            resources {
                cpu = 500
                memory = 1024
                network {
                    port "db" {
                        static = 27018
                    }
                }
            
            }

            service {
                name = "mongodb"
                port = "db"
                tags = [
                    "mongodb",
                    "urlprefix-:27018 proto=tcp"
                ]

                check {
                    type = "http"
                    path = "/"
                    interval = "10s"
                    timeout = "5s"
                    port = "27018"
                    address_mode = "driver"
                }
            }
        }
    }
}