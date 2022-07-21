// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        // ABI

        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.00000000
        // Converts (typecasts) int256 price into uint256 and returns value
        return uint256(price * 1e10); // 1**10 == 10000000000
    }

    // function getVersion() internal view returns (uint256) {
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(
    //         0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    //     );
    //     return priceFeed.version();
    // }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        //Always do multiplications and addition operations before you divide
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInusd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInusd;
    }
}
