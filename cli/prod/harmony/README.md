In order to use this script you need to have add your BNB wallet key added. Currently the script doesn't have compatibility with this, so you have to use the bnbcli program in the side directories from this one (currently ../0.6.1/). To add the keys you can find the commands here: https://docs.binance.org/keys.html. You can either import or create a new one.

Additionally, script by default uses the linux distribution, so if using Mac, the BNBCLI variable needs to be set to the darwin release, not the linux one.

Included is also a script that takes a basic textfile as it's first parameter and outputs a file called "rewards.json" in the correct format for the bnbcli to take. The textfile needs to just have two columns, the address and the amount sent. Note that you can only send one sole memo to multiple addresses, so if you need to have multiple memos, you need to use the single send command. This also has the ability to do a repeat, so you could create a textfile to pass in the inputs. The following is an example of this. Parentheses for explanation of each line.

./bc.sh send < rewards.txt
rewards.txt contents:
n (Answer to is this a dry run?)
bnb136ns6lfw4zs5hg4n85vdthaad7hq5m4gtkgf23 (What address?)
568181818100 (Amount?)
y (Confirmation?)
105369067 (Memo?)
Password12 (Password to key?)
y (Another transaction?)
bnb136ns6lfw4zs5hg4n85vdthaad7hq5m4gtkgf23 (What address?)
568181818100 (Amount?)
y (Confirmation?)
105369067 (Memo?)
Password12 (Password to key?)
n (Another transaction?)