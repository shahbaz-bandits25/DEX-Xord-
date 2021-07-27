pragma solidity ^0.8.6;

contract ShahbazToken {
    constructor() {
        string memory tokenName = """SHAHBAZ TOKEN""";
        string memory tokenSymbol = "ST";
    }
    
    //mapping of O=Particular Owner's NFT's
    mapping(address => uint) private NFT;
   
    //mapping of approved operators
    mapping(address => mapping(address => bool)) private allowed;
    
    //mapping of owner of an NFT
    mapping (uint => address) private OWNERS;
    
    // Mapping from token ID to approved address
    mapping(uint256 => address) private  _tokenApprovals;
    
    
    
    event Approval(address  _owner, address  _approved, uint256  _tokenId);
    event Transfer(address  _from, address  _to, uint256  _tokenId);
    event ApprovalForAll(address  _owner, address  _operator, bool _approved);
   
    
    function balanceOf(address _owner) external view returns (uint256 NFTS )
    {
            // if(_owner != address(0))
            // {
            //     return NFT[_owner];
        
            // }
            
            //  else
            //  {
            
            //      return  ;
            //  }
            
            require(_owner != address(0) , "Invalid Address");
            NFTS=NFT[_owner];
                
            
    }
    
      function approve(address _approved, uint256 _tokenId) external payable returns (bool success)
    {
        
       // allowed[msg.sender][_approved] = _tokenId;
       _tokenApprovals[_tokenId] = _approved;
        //return true;
        emit Approval(msg.sender , _approved ,  _tokenId);
        //success = true;
    }
    
    
     function ownerOf(uint256 _tokenId) external view returns (address OWNER)
     {
         OWNER = OWNERS[_tokenId];
         
     }
     
      function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable
      {
          delete NFT[_from];
          NFT[_to] = _tokenId;
          emit Transfer(_from , _to, _tokenId);
      }
      
      function transferFrom(address _from, address _to, uint256 _tokenId)  public payable
      {
          require(_to != address(0),"Enter The Valid Address");
          uint ownerShip = NFT[_from];
          require(ownerShip != _tokenId , "You're not the owner of this NFT");
          address realOwnerr = OWNERS[_tokenId];
          bool authorized = allowed[realOwnerr][_from];
          require(authorized != true , "You're not approved");
          require(_to != address(0) , "Invalid Address");
          delete NFT[_from];
          NFT[_to] = _tokenId;
          emit Transfer(_from , _to, _tokenId);
      }
      
      function setApprovalForAll(address _operator, bool _approved) external
      {
          require(_operator != msg.sender , "Enter Other Address For Approval");
          
          allowed[msg.sender][_operator] = _approved;
          emit  ApprovalForAll(msg.sender, _operator, _approved);
          
          
          
      }
            
            
    function isApprovedForAll(address _owner, address _operator) external view returns (bool)
    {
        return allowed[_owner][_operator] ;
    }
    
     function getApproved(uint256 _tokenId) external view returns (address)
     {
         require(OWNERS[_tokenId] != address(0) , "The Token Is'nt Valid");
          return _tokenApprovals[_tokenId];
         
     }
        

}


contract DeExchange is ShahbazToken
{
    
    
    enum traderStatus{Buyer , Seller}
    struct Order
    {
        uint256 tokenID;
        //string token_Name;
        uint256 desiredPrice;
        address addressOrderPlacer;
        traderStatus IsSeller;
        
    }
    
    mapping(uint256  => Order) ordersMap;
    
     function buyer(uint256 _tokenID  ,uint _desiredPrice , address _orderPlacer) public 
     {
         Order memory Ord;
       // uint256 MyTok = 11;
        
          Ord.tokenID = _tokenID;
          //Ord.token_Name = _tokenName;
          Ord.desiredPrice = _desiredPrice;
          Ord.addressOrderPlacer = _orderPlacer;
          Ord.IsSeller = traderStatus.Buyer;
          //ordersMap[_tokenID] = Ord;
         
       //   require(ordersMap[_tokenID].token_Name == _tokenName  , "Item Isn't Available ");
          require(ordersMap[_tokenID].tokenID == _tokenID , "Item Isn't Available ");
          require(ordersMap[_tokenID].desiredPrice == _desiredPrice, "Price Not Matched");
          require(ordersMap[_tokenID].IsSeller == traderStatus.Seller , "Seller Not Available");
          Trade(ordersMap[_tokenID].addressOrderPlacer , Ord.addressOrderPlacer, Ord.tokenID);

     }
     
      function Seller(uint256 _tokenID  ,uint _desiredPrice , address _orderPlacer) public 
    {
        Order memory Ord;
       // uint256 MyTok = 11;
        
         Ord.tokenID = _tokenID;
         //Ord.token_Name = _tokenName;
         Ord.desiredPrice = _desiredPrice;
         Ord.addressOrderPlacer = _orderPlacer;
         Ord.IsSeller = traderStatus.Seller;
         ordersMap[_tokenID] = Ord;
         
         require(ordersMap[_tokenID].tokenID == _tokenID , "Item Already Exists" );
         
        //  require(ordersMap[_tokenID].desiredPrice == _desiredPrice, "Price Not Matched");
        //  require(ordersMap[_tokenID].IsSeller == traderStatus.Buyer , "Buyer Not Available");

    }
        
        
    
    //Order[] ordersList;
    //Order[] sellersList;
    
    
    // function buyer(uint256 _tokenID ,uint _desiredPrice , address _orderPlacer) public 
    // {
    //     Order memory Ord;
        
    //     Ord.tokenID = _tokenID;
    //     Ord.desiredPrice = _desiredPrice;
    //     Ord.addressOrderPlacer = _orderPlacer;
    //     Ord.IsSeller = false;
        
    //     //ordersList.push(Ord);
        
    //   // uint Length = ordersList.length;
        
    //     for(uint i=0; i<=ordersList.length ;  i++)
    //     {
    //         if(Ord.tokenID == ordersList[i].tokenID &&  Ord.desiredPrice == ordersList[i].desiredPrice && ordersList[i].IsSeller == true)
    //         {
    //             //call trade function
    //             //Trade(ordersList[i].addressOrderPlacer , Ord.addressOrderPlacer, Ord.tokenID);
    //              ordersList.push(Ord);
    //         }
            
    //         else
    //         {
    //             ordersList.push(Ord);
    //         }
            
    //     }
        
        
    // }
    
    // function seller(uint256 _tokenID ,uint _desiredPrice , address _sellOrder) public
    // {
    //     Order memory Sell;
        
    //     Sell.tokenID = _tokenID;
    //     Sell.desiredPrice = _desiredPrice;
    //     Sell.addressOrderPlacer = _sellOrder;
    //     Sell.IsSeller = true;
    //     //ordersList.push(Sell);
        
    //      uint Length = ordersList.length;
        
    //     for(uint i=0; i<=Length ;  i++)
    //     {
    //       // require();
    //         if(Sell.tokenID == ordersList[i].tokenID &&  Sell.desiredPrice == ordersList[i].desiredPrice && ordersList[i].IsSeller == false)
    //         {
    //             //call trade function
    //              //Trade(ordersList[i].addressOrderPlacer , Ord.addressOrderPlacer, Ord.tokenID);
    //              Trade(Sell.addressOrderPlacer , ordersList[i].addressOrderPlacer , Sell.tokenID);
    //         }
            
    //         else
    //         {
    //             //require(Sell.tokenID != ordersList[i].tokenID , "Same ID Error");
    //             ordersList.push(Sell);
    //         }
            
    //     }
        
        
        
    // }
    
    
    
    
     function Trade(address _from, address _to, uint256 _tokenId) public   
     {
         address Sender = _from;
         address Reciever = _to;
         uint256 Id = _tokenId;
        
         transferFrom( Sender,  Reciever,  Id);
     }
    
    // function DisplayArray() public view returns(Order[] memory)
    // {
    //     return ordersList;
    //     // for(uint256 i=0 ; i<ordersList.length ; i++)
    //     // {
    //     //   return 
    //     // }
    // }
    
}