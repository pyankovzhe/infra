resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  network     = "default"
  description = "Allow SSH from any source"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.ssh_rule_source_ranges}"
}
