# Lottery
**If you like taking risks, THIS IF FOR YOU! Two lottery smart contracts. With and without the chainlinkVRF. Roll your dice whenever you're ready!**

```
lotteryId
```
*Used for keeping count of all the previously played lottery rounds.*

```
owner
```
*Address of the account which deployed the smart contract.*

```
players
```
*Array for tracking participating players. Gets reset as soon as owner calls `pickWinner()`*

```
lotteryHistory
```
*History of all the previous lottery winner addresses.*

```
enter()
```
*Function to participate in the lottery. Participants have to pay at least 10 Finney. Winner gets all funds deposited into contract.*

```
getRandomNumber()
```
*Function to generate random number to generate lottery winner randomly.*

```
pickWinner()
```
*Function only callable by owner. Gets random winner and sets `players` back to 0.*

```
getPlayers()
```
*Function which returns string of all participant addresses.*

```
getContractBalance()
```
*Shows current contract balance.*
