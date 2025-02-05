echo "Longer Test for LP VaR"

credmark-dev run finance.var-dex-lp -i '{"pool": {"address":"0xCEfF51756c56CeFFCA006cD410B03FFC46dd3a58"},
"window":"280 days", "interval":10, "confidences": [0.01], "lower_range": 0.01, "upper_range":0.01, "price_model":"chainlink.price-usd"}' -b 13909787 -j --api_url=http://localhost:8700

for range_of_pool in 0.01 0.05 0.1 0.2 0.4 0.6 0.8 1.0; do
    echo ${range_of_pool}
    credmark-dev run finance.var-dex-lp -i '{"pool": {"address":"0xcbcdf9626bc03e24f779434178a73a0b4bad62ed"},
    "window":"280 days", "interval":10, "confidences": [0.01], "lower_range": '${range_of_pool}', "upper_range": '${range_of_pool}', "price_model":"chainlink.price-usd"}' -b 13909787 -j --api_url=http://localhost:8700
done

# Uniswap V2: 0xCEfF51756c56CeFFCA006cD410B03FFC46dd3a58
# Uniswap V3: 0xcbcdf9626bc03e24f779434178a73a0b4bad62ed

# Uniswap V3:0x4674abc5796e1334B5075326b39B748bee9EaA34

# run_model_historical("finance.var-dex-lp", model_input={"pool": {"address":"0x4674abc5796e1334B5075326b39B748bee9EaA34"}, "window":"280 days", "interval":10, "confidences": [0.01], "lower_range": 0.01, "upper_range":0.01, "price_model":"chainlink.price-usd"}, window="120 days")
# models.finance.var_dex_lp({"pool": {"address":"0xCEfF51756c56CeFFCA006cD410B03FFC46dd3a58"}, "window":"280 days", "interval":10, "confidences": [0.01], "lower_range": 0.01, "upper_range":0.01, "price_model":"chainlink.price-usd"}, block_number=14830357)

echo Dex LP VaR
sushi_pools="0x6a091a3406E0073C3CD6340122143009aDac0EDa
            0x397ff1542f962076d0bfe58ea045ffa2d347aca0
            0xceff51756c56ceffca006cd410b03ffc46dd3a58
            0xe12af1218b4e9272e9628d7c7dc6354d137d024e
            0xd4e7a6e2d03e4e48dfc27dd3f46df1c176647e38
            0x06da0fd433c1a5d7a4faa01111c044910a184553
            0x055475920a8c93cffb64d039a8205f7acc7722d3
            0xc3d03e4f041fd4cd388c549ee2a29a9e5075882f
            0xdB06a76733528761Eda47d356647297bC35a98BD
            0x795065dcc9f64b5614c407a6efdc400da6221fb0"

univ2_pools="0xb4e16d0168e52d35cacd2c6185b44281ec28c9dc
            0x21b8065d10f73ee2e260e5b47d3344d3ced7596e
            0x9928e4046d7c6513326ccea028cd3e7a91c7590a
            0x0d4a11d5eeaac28ec3f61d100daf4d40471f1852
            0xe1573b9d29e2183b1af0e743dc2754979a40d237
            0xae461ca67b15dc8dc81ce7615e0320da1a9ab8d5
            0xccb63225a7b19dcf66717e4d40c9a72b39331d61
            0x3041cbd36888becc7bbcbc0045e3b1f144466f5f
            0x9fae36a18ef8ac2b43186ade5e2b07403dc742b1
            0x61b62c5d56ccd158a38367ef2f539668a06356ab
            0xCEfF51756c56CeFFCA006cD410B03FFC46dd3a58"

univ3_pools="0x8ad599c3a0ff1de082011efddc58f1908eb6e6d8
            0xcbcdf9626bc03e24f779434178a73a0b4bad62ed
            0x5777d92f208679DB4b9778590Fa3CAB3aC9e2168
            0x88e6a0c2ddd26feeb64f039a2c41296fcb3f5640
            0xc63b0708e2f7e69cb8a1df0e1389a98c35a76d52
            0x3416cf6c708da44db2624d63ea0aaef7113527c6
            0x4e68ccd3e89f51c3074ca5072bbac773960dfa36
            0x97e7d56a0408570ba1a7852de36350f7713906ec
            0x7379e81228514a1d2a6cf7559203998e20598346
            0x99ac8ca7087fa4a2a1fb6357269965a2014abc35
            0x4674abc5796e1334B5075326b39B748bee9EaA34"

for pool in $sushi_pools $univ2_pools $univ3_pools; do
    credmark-dev run finance.var-dex-lp -i '{"pool": {"address":"'${pool}'"},
"window":"10 days", "interval":1, "confidences": [0.01], "lower_range": 0.01, "upper_range":0.01, "price_model":"chainlink.price-usd"}' -b 14830357 -j --api_url=http://localhost:8700
done
