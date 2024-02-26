    // Définition de l'infrastructure nécessaire (par exemple, une machine virtuelle pour K3s)
    provider "docker" {
      // Configuration du fournisseur Docker
    }

    // Définition des ressources nécessaires (par exemple, une machine virtuelle)
    resource "docker_container" "k3s" {
      // Configuration de la machine virtuelle pour K3s
    }
