job "home-assistant" {
    datacenters = ["dc1"]

    group "home-assistant" {
        count = 1
        task  "home-assistant" {
            driver = "docker"

            config {
                image = "homeassistant/home-assistant:latest"
                port_map {
                    http = 8123
                }
            }

            resources {
                network {
                    mbits = 1
                    port "http" {}
                }
            }
        }
    }
}