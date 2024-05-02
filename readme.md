## 🚀 Install tosleep

To install tosleep, follow these steps:

Linux:

```
git clone https://github.com/MatheusSiqueiraDev/start-automatically-linux-script.git
cd start-automatically-linux-script
sudo chmod +x tosleep.sh
sudo cp tosleep.sh /usr/local/bin/tosleep
```

## Options

- `-h, help`: Show help message.
- `-d, day`: Set the number of days to wake up again.
- `-t, today`: Wake up on the same day.

If no option is given, it will start the next day.

Example usage:

```bash
tosleep -d