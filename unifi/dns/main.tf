locals {
  dns_config = templatefile(
    "${path.module}/files/dns.tftpl",
    {
      serverrecord  = var.serverrecord
      addressrecord = var.addressrecord
      hostrecord    = var.hostrecord
      cnamerecord   = var.cnamerecord
    }
  )
  dns_file = "/mnt/data/dns.d/${random_pet.pet.id}.dns"
}

resource "random_pet" "pet" {
  length = 3
}

resource "null_resource" "copy-dns" {
  triggers = {
    foobar = local.dns_config
  }

  provisioner "file" {
    content     = local.dns_config
    destination = local.dns_file

    connection {
      type        = "ssh"
      user        = var.sshuser
      private_key = file(pathexpand("${var.sshkey}"))
      host        = var.dnsserver
    }
  }

  provisioner "local-exec" {
    command = "ssh ${self.connection.user}@${self.connection.host} 'rm -f ${self.destination} && /mnt/data/on_boot.d/11-create-local-dns-conf.sh'"
    when    = destroy
  }
}

resource "null_resource" "refresh-dns" {
  depends_on = [
    null_resource.rancher-test-dns
  ]

  provisioner "local-exec" {
    command = "ssh ${var.sshuser}@${var.dnsserver} /mnt/data/on_boot.d/11-create-local-dns-conf.sh"
  }
}
