--------------------------------------------------------------------------------
-- Title:               MIME.lua
-- Description:         Like a square peg in a round hole
-- Author:              Raphaël Szwarc http://alt.textdrive.com/lua/
-- Creation Date:       January 30, 2007
-- Legal:               Copyright (C) 2007 Raphaël Szwarc
--                      Under the terms of the MIT License
--                      http://www.opensource.org/licenses/mit-license.html
--
-- Modified Title:      simpleMultipart.lua
-- Modified by:         Naoya Yamamoto http://twitter.com/ymmtny
-- Modifiied Date:      September 26, 2012
-- Description:         riak returns multiparts. this module simply parse it
--[[
   local function networkListener( event )
    if ( event.isError ) then
        if event.status ~=nil then
      print( "Network error!:"..event.status)
      else
          print( "Network error!")
      end
    else
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
  -- see ibm's riak tutorial http://www.ibm.com/developerworks/opensource/library/os-riak1/index.html
  network.request("http://localhost:8091/riak/albums/TheRiver/artists,_,0/artists,collaborator,1",
   "GET", networkListener,  params)

]]--
--------------------------------------------------------------------------------
module(..., package.seeall)

-- import dependencies
--local table = require( 'table' )

local getmetatable = getmetatable
local ipairs = ipairs
local module = module
local pcall = pcall
local require = require
local setmetatable = setmetatable
local tostring = tostring
local type = type

--------------------------------------------------------------------------------
-- MIMEType
--------------------------------------------------------------------------------

--module( 'MIMEType' )
--_VERSION = '1.0'

a = 'application/x-archive'
ag = 'application/x-applixgraphics'
aiff = 'audio/x-aiff'
arj = 'application/x-arj'
arts = 'application/x-artsbuilder'
as = 'application/x-applixspread'
au = 'audio/basic'
avi = 'video/x-msvideo'
aw = 'application/x-applixword'
bak = 'application/x-trash'
bib = 'text/x-bibtex'
bmp = 'image/x-bmp'
bz = 'application/x-bzip'
bz2 = 'application/x-bzip2'
c = 'text/x-csrc'
cc = 'text/x-c++src'
cgm = 'image/cgm'
class = 'application/x-java'
cls = 'text/x-tex'
cpio = 'application/x-cpio'
cpp = 'text/x-c++src'
csh = 'application/x-shellscript'
css = 'text/css'
cssl = 'text/css'
cxx = 'text/x-c++src'
deb = 'application/x-debian-package'
desktop = 'application/x-desktop'
diff = 'text/x-diff'
dvi = 'application/x-dvi'
eps = 'image/x-eps'
epsf = 'image/x-eps'
epsi = 'image/x-eps'
exe = 'application/x-executable'
flc = 'video/x-flic'
fli = 'video/x-flic'
g3 = 'image/fax-g3'
gif = 'image/gif'
gsf = 'application/x-font'
gz = 'application/x-gzip'
h = 'text/x-chdr'
hh = 'text/x-c++hdr'
htm = 'text/html'
html = 'text/html'
ico = 'image/x-ico'
ics = 'text/calendar'
it = 'audio/x-mod'
jar = 'application/x-jar'
java = 'text/x-java'
jng = 'image/x-jng'
jpeg = 'image/jpeg'
jpg = 'image/jpeg'
kar = 'audio/x-karaoke'
kdelnk = 'application/x-desktop'
ksysv = 'application/x-ksysv'
ksysv_log = 'text/x-ksysv-log'
ktheme = 'application/x-ktheme'
lha = 'application/x-lha'
log = 'text/x-log'
ltx = 'text/x-tex'
lua = 'text/plain'
lyx = 'text/x-lyx'
lzh = 'application/x-lha'
lzo = 'application/x-lzop'
m15 = 'audio/x-mod'
m3u = 'audio/x-mpegurl'
man = 'application/x-troff-man'
mid = 'audio/x-midi'
mng = 'video/x-mng'
moc = 'text/x-moc'
mod = 'audio/x-mod'
moov = 'video/quicktime'
mov = 'video/quicktime'
mp3 = 'audio/x-mp3'
mpeg = 'video/mpeg'
mpg = 'video/mpeg'
mtm = 'audio/x-mod'
o = 'application/x-object'
ogg = 'audio/ogg'
old = 'application/x-trash'
p = 'text/x-pascal'
pas = 'text/x-pascal'
patch = 'text/x-diff'
pcd = 'image/x-photo-cd'
pdf = 'application/pdf'
perl = 'application/x-perl'
pfa = 'application/x-font'
pfb = 'application/x-font'
php = 'text/x-php'
php3 = 'text/x-php'
pl = 'text/x-perl'
pls = 'audio/x-scpls'
pm = 'text/x-perl'
png = 'image/png'
po = 'application/x-gettext'
pot = 'application/x-gettext'
ppt = 'application/mspowerpoint'
ppz = 'application/mspowerpoint'
ps = 'application/postscript'
py = 'application/x-python'
pyc = 'application/x-python-bytecode'
qt = 'video/quicktime'
qtvr = 'video/quicktime'
ra = 'audio/x-pn-realaudio'
ram = 'audio/x-pn-realaudio'
rar = 'application/x-rar'
rdf = 'text/rdf'
rm = 'audio/x-pn-realaudio'
roff = 'application/x-troff'
rpm = 'application/x-rpm'
rss = 'text/rss'
rtf = 'text/rtf'
s3m = 'audio/x-mod'
sgml = 'text/sgml'
sgrd = 'application/x-ksysguard'
sh = 'application/x-shellscript'
shell = 'application/x-konsole'
shtml = 'text/x-ssi-html'
sik = 'application/x-trash'
smi = 'audio/x-pn-realaudio'
smil = 'application/smil'
snd = 'audio/basic'
stm = 'audio/x-mod'
sty = 'text/x-tex'
svg = 'image/svg+xml'
swf = 'application/x-shockwave-flash'
tar = 'application/x-tar'
tcl = 'text/x-tcl'
tex = 'text/x-tex'
tgz = 'application/x-tgz'
tif = 'image/tiff'
tiff = 'image/tiff'
tk = 'text/x-tcl'
tr = 'application/x-troff'
ts = 'application/x-linguist'
ttf = 'application/x-truetype-font'
txt = 'text/plain'
tzo = 'application/x-tzo'
ui = 'application/x-designer'
ult = 'audio/x-mod'
uni = 'audio/x-mod'
vcs = 'text/x-vcalendar'
vct = 'text/x-vcard'
war = 'application/x-webarchive'
wav = 'audio/x-wav'
wpd = 'application/wordperfect'
xbm = 'image/x-xbm'
xcf = 'image/x-xcf-gimp'
xlc = 'application/msexcel'
xll = 'application/msexcel'
xls = 'application/msexcel'
xlw = 'application/msexcel'
xm = 'audio/x-mod'
xml = 'text/xml'
xpm = 'image/x-xpm'
z = 'application/x-compress'
zip = 'application/x-zip'
zoo = 'application/x-zoo'

--------------------------------------------------------------------------------
-- MIMEMultipartFormData
--------------------------------------------------------------------------------

--module( 'MIMEMultipartFormData' )
--_VERSION = '1.0'

local MIMEMultipartFormData = function()

    local _M ={}

    local self = setmetatable( _M, {} )
    local meta = getmetatable( self )

    local function ReadFormData( aMultipart )
        local aFormData = {}
       
        aFormData.boundary = aMultipart.boundary
       
        for anIndex, aPart in ipairs( aMultipart ) do
    	        local aHeader = aPart.header[ 'content-disposition' ] or {}
    	        local aDisposition = ( aHeader.value or '' ):lower()
    	       
    	        if aDisposition == 'form-data' then
    	            local aParameter = aHeader.parameter or {}
    	            local aKey = aParameter[ 'name' ]
    	           
    	            if aKey then
    	                local aKey = aKey:lower()
    	                local aValue = aPart.content
    	                local aFileName = aParameter[ 'filename' ]
    	                local aForm = { key = aKey, value = aValue, filename = aFileName }
    	           
    	                aFormData[ #aFormData + 1 ] = aForm
                end
            end
        end
       
        return aFormData
    end

    local function NewFormData( aValue, aHeader )
        --local MIMEMultipart = require( 'MIMEMultipart' )
        local aMIMEMultipart = MIMEMultipart()
        local aFormData = nil

        if type( aValue ) == 'table' then
            aFormData = ReadFormData( aMIMEMultipart( WriteFormData( aValue ), aHeader ) )
        else
            aFormData = ReadFormData( aMIMEMultipart( aValue, aHeader ) )
        end
       
        setmetatable( aFormData, self )
       
        return aFormData
    end

    function meta:__call( aValue, aHeader )
        return NewFormData( aValue, aHeader )
    end

    function self:__index( aKey )
        if aKey then
            local someForms = {}
           
            aKey = aKey:lower()
       
            for anIndex, aForm in ipairs( self ) do
                if aKey == aForm.key then
                    someForms[ #someForms + 1 ] = aForm
                end
            end

            return unpack( someForms )
        end
       
        return nil
    end

    function self:__concat( aValue )
        return tostring( self ) .. tostring( aValue )
    end

    function self:__tostring()
        return 'WriteFormData' --WriteFormData( self )
    end

    return _M
end 
--------------------------------------------------------------------------------
-- MIMEMultipart
--------------------------------------------------------------------------------

--module( 'MIMEMultipart' )
--_VERSION = '1.0'
local MIMEMultipart = function()
    local _M = {}
    local self = setmetatable( _M, {} )
    local meta = getmetatable( self )

    local function ReadBoundary( aHeader )
        local aType = aHeader[ 'content-type' ] or {}
        local aParameter = aType.parameter or {}
        local aBoundary = aParameter[ 'boundary' ]
        return aBoundary
    end

    local function ReadMultipart( aValue, aBoundary )
        --local MIME = require( 'MIME' )
        local aMIME = MIME()
        local aMultipart = { boundary = aBoundary }
        local aBoundary = '--' .. aBoundary
        local aLength = aBoundary:len()
        local aStart = 1
        local anEnd = nil
        --print ("ReadMultipart")
          --  print(aBoundary)
            --print (aValue)

         while true do
            aStart = aValue:find( aBoundary, aStart, true )
            if aStart then
                aStart = aStart + aLength
                anEnd = aValue:find( aBoundary, aStart, true )
                --print(anEnd)
                if anEnd then
                    --aStart = aValue:find( '\r\n', aStart, true ) + 2
                    aStart = aValue:find( '\n', aStart, true ) + 1
              
                  -- print (aValue:sub( aStart, anEnd - 3 ))
                   --print("back to MIME()")
                   --print(aValue:sub( aStart, anEnd - 3 ))
                   aMultipart[ #aMultipart + 1 ] = aMIME( aValue:sub( aStart, anEnd - 3 ) )
                   
                 else
                     break
                end
            else
                 break
            end
         end
         return aMultipart
    end

    local function NewMultipart( aValue, aHeader )
        local aMultipart = nil
        if type( aValue ) == 'table' then
            aMultipart = ReadMultipart( WriteMultipart( aValue ), aValue.boundary )
        else
            --print(aValue)
            aMultipart = ReadMultipart( tostring( aValue or '' ), ReadBoundary( aHeader ) )
        end
       
        setmetatable( aMultipart, self )
       
        return aMultipart
    end

    function meta:__call( aValue, aHeader )
        return NewMultipart( aValue, aHeader )
    end

    function self:__concat( aValue )
        return tostring( self ) .. tostring( aValue )
    end

    function self:__tostring()
        return 'WriteMultipart' --WriteMultipart( self )
    end
    return _M
end
--------------------------------------------------------------------------------
-- MIMEHeader
--------------------------------------------------------------------------------

--module( 'MIMEHeader' )
--_VERSION = '1.0'

local MIMEHeader = function()
    local _M = {}
    local self = setmetatable( _M, {} )
    local meta = getmetatable( self )

    local function Trim( aString )
        if aString ~= nil then
            aString = aString:gsub( '^[%c%s]*', '' )
            aString = aString:gsub( '[%s%c]*$', '' )
        end
       
        return aString
    end

    local function ReadKey( aValue )
        local anIndex = aValue:find( ':', 1, true ) or ( aValue:len() + 1 )
        local aKey = aValue:sub( 1, anIndex - 1 ):lower()
        --print(aKey)
        return Trim( aKey )
    end

    local function ReadValue( aValue )
        local aValue = aValue .. ';'
        local anIndex = aValue:find( ':', 1, true ) or 1
        local anotherIndex = 1
        if anIndex > 1 then
          anotherIndex = aValue:find( ';%s*([^%s=]+)%s*=(.-);' ) or aValue:len()
        else  
          anotherIndex = aValue:find( ';%s*([^%s=]+)%s*=(.-);' ) or 1
        end  
        --local aValue = aValue:sub( anIndex + 1, anotherIndex - 1 )
        local aValue = aValue:sub( anIndex+1 , anotherIndex - 1 )
        
        --print(aValue)
        return Trim( aValue )
    end

    local function ReadParameter( aValue )
        local aValue = aValue .. ';'
        local aParameter = {}
       
        for aKey, aValue in aValue:gmatch( '%s*([^%s=]+)%s*=(.-);' ) do
                if aValue:sub( 1, 1 ) == '"' then
                        aValue = aValue:sub( 2, aValue:len() - 1 )
                end
       
                aParameter[ Trim( aKey ):lower() ] = Trim( aValue )
        end
       
        return aParameter
    end

    local function ReadHeader( aValue )
        --print (aValue)
        local aHeaderKey = ReadKey( aValue )
        local aHeaderValue = ReadValue( aValue )
        local aHeaderParameter = ReadParameter( aValue )
        local aHeader = { key = aHeaderKey, value = aHeaderValue, parameter = aHeaderParameter }
        --print(aHeaderKey ..":"..aHeaderValue)
        -- for k, v in pairs(aHeaderParameter) do
        --     print(k..":"..v)
        -- end    
        _M.aHeaderKey = aHeaderKey -- ymmt
        return aHeader
    end

    local function NewHeader( aValue )
        local aHeader = nil
       
        if type( aValue ) == 'table' then
            aHeader = ReadHeader( WriteHeader( aValue ) )
        else
            aHeader = ReadHeader( tostring( aValue or '' ) )
        end
       
        setmetatable( aHeader, self )
       
        return aHeader
    end

    function meta:__call( aValue )
        return NewHeader( aValue )
    end

    function self:__concat( aValue )
        return tostring( self ) .. tostring( aValue )
    end

    function self:__eq( aValue )
        return tostring( self ) == tostring( aValue )
    end

    function self:__lt( aValue )
        return tostring( self ) < tostring( aValue )
    end

    function self:__tostring()
        --return 'WriteHeader' --WriteHeader( self )
        return tostring(_M.aHeaderKey)
    end

  return _M
end
--------------------------------------------------------------------------------
-- MIMEHeaders
--------------------------------------------------------------------------------

--module( 'MIMEHeaders' )
--_VERSION = '1.0'

local MIMEHeaders = function()
    local _M = {}

    local self = setmetatable( _M, {} )
    local meta = getmetatable( self )

    local function ReadHeaders( aValue )
        --local MIMEHeader = require( 'MIMEHeader' )
        --print (aValue)
        local aMIMEHeader = MIMEHeader()
        local aHeader = {}
        local aBuffer = nil
        local aStart = 1
        local anEnd = nil
        while true do
     --    anEnd = aValue:find( '\r\n', aStart, true )
           anEnd = aValue:find( '\n', aStart, true )
           --print(anEnd)
            if anEnd then
                --local aLine = aValue:sub( aStart, anEnd - 1 )
                local aLine = aValue:sub( aStart, anEnd  )

                --print (aLine)              
                anEnd = anEnd +1
                aStart = anEnd
                --print (aStart)
                if aLine ~= '' then
                    local aChar = aLine:sub( 1, 1 )
       
                    if aChar ~= ' ' and aChar ~= '\t' then 
                        if aBuffer then
                            --print(#aHeader)
                            aHeader[ #aHeader + 1 ] = aMIMEHeader( table.concat( aBuffer, ' ' ) )
                            aMIMEHeader = MIMEHeader() --ymmt
                        end
               
                        aBuffer = {}
                    end
                    
                    aBuffer[ #aBuffer + 1 ] = aLine
                else
                    print("break")
                    break
                end
            else
                break
            end
        end
       
        if aBuffer and #aBuffer > 0 then
            aHeader[ #aHeader + 1 ] = aMIMEHeader( table.concat( aBuffer, ' ' ) )
        end
       
        return aHeader, ( anEnd or aStart )
    end

    local function NewHeaders( aValue )
        local someHeaders = nil
        local anEnd = nil
        if type( aValue ) == 'table' then
            someHeaders, anEnd = ReadHeaders( WriteHeaders( aValue ) )
        else
            someHeaders, anEnd = ReadHeaders( tostring( aValue or '' ) )
        end
       
        setmetatable( someHeaders, self )
       
        return someHeaders, anEnd
    end

    function meta:__call( aValue )
        return NewHeaders( aValue )
    end

    function self:__index( aKey )
        if aKey then
            local someHeaders = {}
           
            aKey = aKey:lower()
            --print(aKey)
            for anIndex, aHeader in ipairs( self ) do
                if aKey == aHeader.key then
                    someHeaders[ #someHeaders + 1 ] = aHeader
                    --print (aHeader)
                end
            end
            if #someHeaders > 0 then
              return unpack( someHeaders )
            end  
        end
       
        return nil
    end

    function self:__concat( aValue )
        return tostring( self ) .. tostring( aValue )
    end

    function self:__eq( aValue )
        return tostring( self ) == tostring( aValue )
    end

    function self:__tostring()
        return 'WriteHeaders'
    end
    return _M
end

--------------------------------------------------------------------------------
-- MIME
--------------------------------------------------------------------------------

--module( 'MIME' )
--_VERSION = '1.0'

Riak={}

MIME = function()
  local _M = {}

    local self = setmetatable( _M, {} )

    local meta = getmetatable( self )

    local function Capitalize( aValue )
        return ( aValue:lower():gsub( '(%l)([%w_\']*)', function( first, rest ) return first:upper() .. rest end ) )
    end

    local function ReadType( aHeader )
        local aHeader     = aHeader or {}
        local aTypeHeader = aHeader['content-type' ] or  {}
        local aLocation   = aHeader['location'] or {} 
        local aLink       = aHeader['link'] or {}
        local aType       = ( aTypeHeader.value or 'text/plain' ):lower()

        local riakData = {type=nil, location=nil, link=nil} 
        --print("ReadType")
        if aTypeHeader.value ~= nil  then
            --print ("type:"..aTypeHeader.value)
            riakData.type = aTypeHeader.value
        end    
        if aLocation.value~=nil then    
           --print ("location:"..aLocation.value)
           riakData.location = aLocation.value
        end
        if aLink.value~=nil then
          -- print ("link:"..aLink.value)  
           -- for k, v in pairs (aLink.parameter) do
           --   print (k..":"..v)
           -- end
           local s = aLink.parameter['riaktag']
           local index = string.find(s,',')
           riakData.link = string.sub(s,1,index-2) 
           --print ("link:"..riakData.link)        
        end
       
        if aTypeHeader.value ~= "multipart/mixed" then
            --print (aTypeHeader.value)
            Riak[#Riak+1] = riakData
        end

        return aType
    end

    local function ContentModuleName( aType )
        local aName = 'MIME' .. Capitalize( aType ):gsub( '[^%w]', '' )
--        local ok, aModule = pcall( require, aName )
--        print (aName)
        return aName
    end    

    local function ContentModule( aType )
        local aName = 'MIME' .. Capitalize( aType ):gsub( '[^%w]', '' )
        local ok, aModule = pcall( require, aName )
        --print ("ContentModule:"..aName)
        if aName == "MIMEMultipart" then
          -- ymmt
          --print("test")
         return MIMEMultipart() -- this calls MIME() inside again so it is recursive
        end                      -- thus eventually ReadyType recursively outputs each header value

        if not ok then
            local anIndex = aType:find( '/', 1, true )
           
            if anIndex then
                --print(aType:sub( 1, anIndex - 1 ) )
                aModule = ContentModule( aType:sub( 1, anIndex - 1 ) )
            else
                aModule = nil
            end
        end
        return aModule
    end

    local function ReadContent( aValue, aType, aHeader )
        local aModule = ContentModule( aType ) -- this recursives inside so multi parts are parsed
        if aModule then
            --print("ReadContent")
            --print(aValue)
            return aModule( aValue, aHeader ) 
        end
            --print("ReadContent no module")
       
        return aValue
    end

    local function ReadMIME( aValue )
        --print ("ReadMIME")
        --print(aValue)
         --local MIMEHeaders = require( 'MIMEHeaders' )
        local aMIMEHeaders = MIMEHeaders()
        local aHeader, anEnd = aMIMEHeaders( aValue )
        local aType = ReadType( aHeader )
        local aName = ContentModuleName( aType )
        local aContent = ReadContent( aValue, aType, aHeader)
        local aMIME = { header = aHeader, type = aType, content = aContent }
       
        return aMIME
    end
    --]]
    function NewMIME( aValue )
        local aMIME = nil
        if type( aValue ) == 'table' then
            aMIME = ReadMIME( WriteMIME( aValue ) )
        else
            aMIME = ReadMIME( tostring( aValue or '' ) )
        end
       
        setmetatable( aMIME, self )
       
        return aMIME
    end
 
    function meta:__call( aValue )
        return NewMIME( aValue )
    end

    function self:__concat( aValue )
        return tostring( self ) .. tostring( aValue )
    end

    function self:__eq( aValue )
        return tostring( self ) == tostring( aValue )
    end

    function self:__tostring()
        return 'WriteMIME' --WriteMIME( self )
    end
   return _M
end   