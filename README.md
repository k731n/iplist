# iplist
This tool lists available interfaces in a more visually appealing way than usual, and allows us to copy the IP address we need very easily. As you'll see, it's not going to make your life easier, but it's very useful when we're just interested in copying an IP address or seeing the interfaces we have available and whether or not they have an IP address assigned.

![Muestra del script2](https://github.com/user-attachments/assets/c3d6b7b8-7fbf-4d54-a2e0-dcfbd8a46d3b)

### Example:

![Muestra del script](https://github.com/user-attachments/assets/35af5272-ffa2-4feb-a24a-2943c04b52e7)


![image](https://github.com/user-attachments/assets/09678982-f2cd-4c02-91cd-47da9855a36a)


![image](https://github.com/user-attachments/assets/dcd554c5-8b5f-4873-b657-9fe3dd0bdf94)

### Silent mode:

![image](https://github.com/user-attachments/assets/7ec188a3-e8eb-4390-b18b-d052cbf544ac)


## Install 

### Zsh

```bash
git clone https://github.com/k731n/iplist.git
cd iplist
chmod +x iplist.sh
echo 'alias iplist="'$(pwd)'/iplist.sh"' >> ~/.zshrc
source ~/.zshrc
```

### Bash

```bash
git clone https://github.com/k731n/iplist.git
cd iplist
chmod +x iplist.sh
echo 'alias iplist="'$(pwd)'/iplist.sh"' >> ~/.bashrc
source ~/.bashrc
```
