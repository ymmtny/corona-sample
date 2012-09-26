local function networkListener( event )
  if ( event.isError ) then
  	if event.status ~=nil then
    print( "Network error!:"..event.status)
    else
      print( "Network error!")
    end
  else
   --print ( "STATUS:"..event.status.." RESPONSE: " .. event.response )
	  parser = require("simpleMultipart")
		aMIME = parser.MIME()
		aMIME(event.response)
	  for i=1, #parser.Riak do
	  	for k, v in pairs (parser.Riak[i]) do
	     print("["..i.."]"..k..":"..v)
	    end
	  end
  end
end
--
-- Create Riak Data
-- see ibm's riak tutorial http://www.ibm.com/developerworks/opensource/library/os-riak1/index.html
--
local params = {headers={}}
---[[ 
   -- Key/Value
  local artists = {}
  artists.name = "Bruce"
  artists.nickname ="The Boss"
  params.headers["Content-Type"] = "application/json"
  params.body = json.encode(artists)
  --print(params.body)
 
  -- Put
  network.request("http://localhost:8091/riak/artists/"..artists.name, "PUT", networkListener,  params)

	--GET
  params.body=nil
  network.request("http://localhost:8091/riak/artists/"..artists.name, "GET", networkListener,  params)
 
  --Delete
  --network.request("http://localhost:8091/riak/artists/"..artists.name, "DELETE", networkListener,  params)
--]]

---[[
  -- add album The River
  params.headers["Content-Type"] = "text/plain"
  params.headers["Link"] = '</riak/artists/Bruce>; riaktag="performer"'
  params.body = "The River あいうえお"
  network.request("http://localhost:8091/riak/albums/TheRiver", "PUT", networkListener,  params)

  -- add album Born To Run
  params.headers["Content-Type"] = "text/plain"
  params.headers["Link"] = '</riak/artists/Bruce>; riaktag="performer"'
  params.body = "Born To Run 日本語 "
  network.request("http://localhost:8091/riak/albums/BornToRun", "PUT", networkListener,  params)

  -- collaborator Clarence
  params.headers["Content-Type"] = "text/plain"
  params.headers["Link"] = '</riak/artists/Bruce>; riaktag="collaborator"'
  params.body = "Clarence Data 日本語 "
  network.request("http://localhost:8091/riak/artists/Clarence", "PUT", networkListener,  params)

  -- collaborator Steve
	params.headers["Content-Type"] = "text/plain"
	params.headers["Link"] = '</riak/artists/Bruce>; riaktag="collaborator"'
	params.body = "Steve Data"
	network.request("http://localhost:8091/riak/artists/Steve", "PUT", networkListener,  params)
  
  --update link for Bruce
  params.headers["Content-Type"] = "Content-Type: application/json"
  params.headers["Link"] = '</riak/artists/Clarence>; riaktag="collaborator", </riak/artists/Steve>; riaktag="collaborator"'
  params.body = nil
  network.request("http://localhost:8091/riak/artists/Steve", "PUT", networkListener,  params)
--]]

---[[ Test 
  network.request("http://localhost:8091/riak/albums/TheRiver", "GET", networkListener,  params)
  network.request("http://localhost:8091/riak/albums/BornToRun", "GET", networkListener,  params)
  network.request("http://localhost:8091/riak/artists/Clarence", "GET", networkListener,  params)
  network.request("http://localhost:8091/riak/artists/Steve", "GET", networkListener,  params)
--]]

---[[ Test Link  
  params.headers = {}
  network.request("http://127.0.0.1:8091/riak/artists/Clarence/_,collaborator,1", "GET", networkListener,  params)
  network.request("http://127.0.0.1:8091/riak/artists/Bruce/_,collaborator,1", "GET", networkListener,  params)
  network.request("http://localhost:8091/riak/albums/TheRiver/artists,performer,1", "GET", networkListener,  params)
  network.request("http://localhost:8091/riak/albums/TheRiver/artists,_,0/artists,collaborator,1", "GET", networkListener,  params)
--]]
