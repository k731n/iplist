# iplist
Esta herramienta sirve para listar las interfaces disponibles de una manera más bonita y copiar la que necesitemos de una forma muy sencilla. Como verán no es para solucionarte la vida pero sí es muy práctico cuándo solo nos interesa copiar una IP o ver las interfaces que tenemos disponibles y si tienen IP o no

![Muestra del script](https://i.ibb.co/VYcfJkCs/imagen.png)

![Muestra del script2](https://i.ibb.co/sJwx7Svh/imagen.png)

### Instalación (path)

```bash
git clone https://github.com/k731n/iplist.git
cd iplist
chmod +x iplist.sh
sudo cp iplist.sh /usr/bin/iplist 
```

Método 2 (alias)

```bash
git clone https://github.com/k731n/iplist.git
cd iplist
chmod +x iplist.sh
echo 'alias iplist="'$(pwd)'/iplist.sh >> ~/.zshrc"'
source ~/.zshrc
```
