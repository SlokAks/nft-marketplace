module.exports = {

  networks: {
    development: {
     host: "127.0.0.1",    
     port: 8545,            
     network_id: "*",
    },
  },

  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.9",    
      settings: {          
       optimizer: {
         enabled: false,
         runs: 200
       },
       evmVersion: "byzantium"
      }
    }
  }
}
