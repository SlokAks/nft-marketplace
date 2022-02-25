// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./IERC721.sol";

contract Market {

    enum ListingStatus {
        Active,
        Sold, 
        Cancelled
    }

    struct Listing {
        ListingStatus status;
        address seller;
        address token;
        uint tokenId;
        uint price;
    }

    uint private _listingId = 0;
    mapping (uint => Listing) private _listings;

    function listToken(address token, uint tokenId, uint price) public {
        IERC721(token).transferFrom(msg.sender, address(this), tokenId);

        Listing memory listing = Listing(
            ListingStatus.Active,
            msg.sender,
            token, 
            tokenId,
            price
        );

        _listingId++;
        _listings[_listingId] = listing;
    }

    function buyToken(uint listingId) external payable {
        Listing storage listing = _listings[listingId];

        require(listing.status == ListingStatus.Active, "Listing is not active");

        // if(listing.status != ListingStatus.Active) {
        //     revert("Listing is not active");
        // }

        require(msg.sender != listing.seller, "Seller cannot be buyer");
        require(msg.value >= listing.price, "Insufficient payment");

        IERC721(listing.token).transferFrom(address(this), msg.sender, listing.tokenId); 
        payable(listing.seller).transfer(listing.price);     
    }
}