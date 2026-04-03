// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

// 1️⃣ Define a Tweet Struct with author, content, timestamp, likes
// 2️⃣ Add the struct to array
// 3️⃣ Test Tweets

contract Twitter {

    uint16 MAX_LIMIT = 250;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner of the contract can perform this action.");
        _;
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_LIMIT = newTweetLength;
    }

    function createTweet(string memory _tweet) public {
        require(bytes (_tweet).length <= MAX_LIMIT, "YOU'VE REACHED THE TWEET LIMIT!");
        
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(address _owner, uint256 _i) public view returns (Tweet memory) {
        return tweets[_owner][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
    

}