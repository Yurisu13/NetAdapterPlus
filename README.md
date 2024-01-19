![](NetAdapterPlus-2023-01-18.png)
# **NetAdapter+**
## C'est quoi ce truc ?
Il s'agit d'un **script PowerShell** qui permet d'activer et de désactiver vos cartes réseau physiques plus rapidement et plus simplement que ne le permet le Centre Réseau et partage de Windows.

## Pour qui ?
Si tu es sur un environnement **Windows**, que tu es **administrateur** de ton poste, que tu aimes bien utiliser des petits scripts pour tout et pour rien et surtout si ça te prend la tête de ne pas pouvoir désactiver une carte réseau en 3 clics, alors NetAdapter+ est fait pour toi !

## Comment ça s'installe ?
Pas de panique, PowerShell est inclut par défaut sur les systèmes d'exploitation Windows, tu dois juste récupérer mon script !

Attention à l'**ExecutionPolicy** de ton PowerShell, elle est définie par défaut sur **Restricted**, ce qui empêche l'exécution de tous les fichiers *".ps1"*. \
\
Il faut alors lancer PowerShell en tant qu'administrateur et exécuter la commande suivante :

    Set-ExecutionPolicy RemoteSigned

La politique **RemoteSigned** devrait suffire. Si jamais cela ne fonctionne pas, copiez le contenu de mon script directement dans un fichier *".ps1"* créé au préalable.