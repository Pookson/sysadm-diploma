
resource "yandex_vpc_security_group" "bastion-sg" {
  name        = "bastion-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"
  
  ingress {
    protocol       = "TCP"
    description    = "ssh connections from internet to bastion host"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "connections from zabbix-server to zabbix-agent"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }  

  egress {
    protocol       = "TCP"
    description    = "connections from bastion to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "connections from bastion to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "TCP"
    description    = "ssh bastion connections to internal hosts"
    v4_cidr_blocks = ["192.168.10.10/32", "192.168.10.100/32", "192.168.20.10/32", "192.168.30.10/32", "192.168.30.20/32"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix-agent to zabbix-server"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }
}  

resource "yandex_vpc_security_group" "kibana-sg" {
  name        = "kibana-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"
  
  ingress {
    protocol       = "TCP"
    description    = "connections from internet to kibana web interface"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5601
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh connections from bastion to kibana"
    v4_cidr_blocks = ["192.168.30.254/32"]
    port           = 22
  }  

  ingress {
    protocol       = "TCP"
    description    = "connections from elasticsearch to kibana"
    v4_cidr_blocks = ["192.168.10.100/32"]
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "connections from zabbix-server to zabbix-agent"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }  

  egress {
    protocol       = "TCP"
    description    = "connections from kibana to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "connections from kibana to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  } 

  egress {
    protocol       = "TCP"
    description    = "connections from kibana to elasticsearch"
    v4_cidr_blocks = ["192.168.10.100/32"]
    port           = 9200
  }

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix-agent to zabbix-server"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }
}  

resource "yandex_vpc_security_group" "elasticsearch-sg" {
  name        = "elasticsearch-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"
  
  ingress {
    protocol       = "TCP"
    description    = "ssh connections from bastion to elasticsearch"
    v4_cidr_blocks = ["192.168.30.254/32"]
    port           = 22
  }  

  ingress {
    protocol       = "TCP"
    description    = "connections from filebeat to elasticsearch"
    v4_cidr_blocks = ["192.168.10.10/32", "192.168.20.10/32"]
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "connections from kibana to elasticsearch"
    v4_cidr_blocks = ["192.168.30.10/32"]
    port           = 9200
  }

  ingress {
    protocol       = "TCP"
    description    = "connections from zabbix-server to zabbix-agent"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }  

  egress {
    protocol       = "TCP"
    description    = "connections from elasticsearch to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "connections from elasticsearch to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  } 

  egress {
    protocol       = "TCP"
    description    = "connections from elasticsearch to kibana"
    v4_cidr_blocks = ["192.168.30.10/32"]
    port           = 9200
  }

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix-agent to zabbix-server"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }
}  

resource "yandex_vpc_security_group" "zabbix-sg" {
  name        = "zabbix-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"
  
  ingress {
    protocol       = "TCP"
    description    = "connections from internet to zabbix web interface"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh connections from bastion to zabbix"
    v4_cidr_blocks = ["192.168.30.254/32"]
    port           = 22
  }  

  ingress {
    protocol       = "TCP"
    description    = "connections from zabbix-agents to zabbix-server"
    v4_cidr_blocks = ["192.168.10.10/32", "192.168.10.100/32", "192.168.20.10/32", "192.168.30.10/32", "192.168.30.20/32", "192.168.30.254/32"]
    from_port = 10050
    to_port = 10051
  }  

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  } 

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix-agent to zabbix-server"
    v4_cidr_blocks = ["192.168.10.10/32", "192.168.10.100/32", "192.168.20.10/32", "192.168.30.10/32", "192.168.30.20/32", "192.168.30.254/32"]
    from_port = 10050
    to_port = 10051
  }
}  

resource "yandex_vpc_security_group" "webserver-sg" {
  name        = "webserver-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"
  
  ingress {
    protocol       = "TCP"
    description    = "ssh connections from bastion to webserver"
    v4_cidr_blocks = ["192.168.30.254/32"]
    port           = 22
  }  

  ingress {
    protocol       = "TCP"
    description    = "connections from zabbix-server to zabbix-agent"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }

  ingress {
    protocol       = "TCP"
    description    = "connections from load-balancer to webserver"
    v4_cidr_blocks = ["192.168.30.0/24"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "connections from wevbserver to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "TCP"
    description    = "connections from webserver to internet for setup and updates"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  } 

  egress {
    protocol       = "TCP"
    description    = "connections from zabbix-agent to zabbix-server"
    v4_cidr_blocks = ["192.168.30.20/32"]
    from_port = 10050
    to_port = 10051
  }
  
  egress {
    protocol       = "TCP"
    description    = "connections from webserver-filebeat to elasticsearch"
    v4_cidr_blocks = ["192.168.10.100/32"]
    port           = 9200
  }
}