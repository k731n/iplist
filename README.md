# iplist
Esta herramienta sirve para listar las interfaces disponibles de una manera más atractiva visualmente que la habitual, y nos permite copiar la que necesitemos de una forma muy sencilla. Como verás, no es para solucionarte la vida pero sí es muy práctica cuándo solo nos interesa copiar una IP o ver las interfaces que tenemos disponibles y si tienen asignada o no una IP.

![Muestra del script](https://i.ibb.co/d450Q2vS/imagen.png)

![Muestra del script2](https://i.ibb.co/TzbcDxR/imagen.png)

### Instalación 

```bash
git clone https://github.com/k731n/iplist.git
cd iplist
chmod +x iplist.sh
echo 'alias iplist="'$(pwd)'/iplist.sh"' >> ~/.zshrc
source ~/.zshrc
```
