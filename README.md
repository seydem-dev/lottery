# Lottery
**If you like taking risks, THIS IF FOR YOU! Two lottery smart contracts. With and without the chainlinkVRF. Roll your dice whenever you're ready! IT IS HIGHLY RECOMMENDED TO USE `LotteryVRF` IN PRODUCTION.**

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

# LotteryVRF
**LotteryVRF is a lottery where the random number generation is withdrawn from the Chainlink oracles.**

```
owner
```
*Deployer address of `LotteryVRF.sol`*

```
_keyHash
```
*Required for random number generation.*

```
_FEE
```
*Fee required to pay in advance for any smart contract modification.*

```
lotteryId
```
*Counter for how many lotteries have been played.*

```
players
```
*Array of currently participating lottery players.*

```
lotteryWinners
```
*History of all the lottery winners.*

```
enter()
```
*Function which allows users to enter lottery, must pay 0.01 ETH to enter.*

```
getRandomNumber()
```
*Externally gets a (truly) random number.*

```
pickWinner()
```
*Picks random lottery winner, only callable by the owner.*

```
withdrawLink()
```
*Withdraws all link paid in fees, only callable by the owner.*

```
getPlayers()
```
*String of currently participating players.*

```
receive()
```
*Function which enables players to enter the lottery by directly sending ETH to smart contract.*
