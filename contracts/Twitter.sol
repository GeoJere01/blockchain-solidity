// SPDX-License-Identifier: MIT

pragma solidity ^0.8.30;

contract Twitter {

    uint16 MAX_LIMIT = 250;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Tweet {
        uint256 id;
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
            id: tweets[owner].length,
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
    
    function likeTweet(address author, uint256 id) external {  
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");

        tweets[author][id].likes++;
    }

    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");
        require(tweets[author][id].likes > 0, "TWEET HAS NO LIKES");
        
        tweets[author][id].likes--;
    }

}