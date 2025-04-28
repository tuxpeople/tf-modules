locals {
  dns_config = templatefile(
    "${path.module}/templates/dns.tftpl",
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
    content     = local.dns_config
    user        = var.sshuser
    host        = var.dnsserver
    destination = local.dns_file
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
    command = "ssh ${self.triggers.user}@${self.triggers.host} 'rm -f ${self.triggers.destination} && /mnt/data/on_boot.d/11-create-local-dns-conf.sh'"
    when    = destroy
  }
}

resource "null_resource" "refresh-dns" {
  depends_on = [
    null_resource.copy-dns
  ]

  provisioner "local-exec" {
    command = "ssh ${var.sshuser}@${var.dnsserver} /mnt/data/on_boot.d/11-create-local-dns-conf.sh"
  }
}
