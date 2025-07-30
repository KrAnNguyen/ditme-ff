
    local GetKey = "https://t.me/lsModgaming"
    local API = "https://anotepad.com/notes/275mb7bw"
    local savedKeyFile = "saved_key.txt"
 
 
    function ReadSavedKey()
        local file = io.open(savedKeyFile, "r")
        if file then
            local savedKey = file:read("*a")
            file:close()
            return savedKey
        end
        return nil
    end
    
    
    function SaveKey(key)
        local file = io.open(savedKeyFile, "w")
        if file then
            file:write(key)
            file:close()
            gg.toast("Lưu Key Thành Công!")
        end
    end


    function DeleteKey()
        os.remove(savedKeyFile)
        gg.toast("Đã xoá key!")
    end
    
    
    local GetData = (gg.makeRequest(API).content)
    if not GetData then
        gg.alert("Lỗi khi lấy dữ liệu!")
        return
    end
    
   

    KeyOnline = string.match(GetData, "Key:%s*([%w%d]+)")
    ExpireDate = string.match(GetData, "ExpireDate:%s*(%d%d%d%d%-%d%d%-%d%d)")
    
    

    if KeyOnline == nil then
        gg.alert("Error fetching key! Kiểm tra lại format trong page note.")
        return
    end
    if ExpireDate == nil then
        gg.alert("Error fetching expire date! Kiểm tra lại format trong page note.")
        return
    end
    
    
    local CurrentDate = os.date("%Y-%m-%d")
    if CurrentDate > ExpireDate then
        gg.alert("Script đã hết hạn!\nExpire Date: " .. ExpireDate)
        os.exit()
    end
    
    
    local savedKey = ReadSavedKey()
    if savedKey and savedKey == KeyOnline then
        gg.toast("Tự động đăng nhập thành công!\nExpire Date: " .. ExpireDate)
    else
       
        local Pastek = gg.prompt({"Vui lòng nhập key để vào script"}, nil, {"text"})
        if Pastek == nil or Pastek[1] == "" then
            gg.alert("Key sai hoặc hết hạn!")
            return
        end
    
        if Pastek[1] ~= KeyOnline then
            local choice = gg.choice({"Copy Link", "OK"}, nil, "Sai mật khẩu!\nVui lòng vô nhóm để lấy key:\n"..GetKey)
            if choice == 1 then
                gg.copyText(GetKey)
                gg.alert("Link đã được sao chép vào clipboard!")
            end
            return
        else
            
            local saveChoice = gg.choice({"Lưu key", "Không Lưu"}, nil, "Đăng nhập thành công!\nBạn có muốn lưu key cho lần sau dùng không?")
            if saveChoice == 1 then
                SaveKey(Pastek[1])
            end
        end
    end
    

    if gg.choice({"Xoá key đã lưu", "Tiếp tục đăng nhập"}, nil, "Quản lý key đã lưu") == 1 then
        DeleteKey()
    end
    
local SaveOFF = {}

local function hex2tbl(hex)
  local ret = {}
  hex:gsub('%S%S', function(ch)
    ret[#ret + 1] = ch
    return ''
  end)
  return ret
end

local function getValues(lib, address, length)
  local values = {}
  for i = 1, length do
    values[i] = {
      address = lib + address + i - 1,
      flags = gg.TYPE_BYTE
    }
  end
  return gg.getValues(values)
end

local function setValues(lib, address, values)
  local set = {}
  for i = 1, #values do
    set[i] = {
      address = lib + address + i - 1,
      value = values[i],
      flags = gg.TYPE_BYTE
    }
  end
  gg.setValues(set)
  gg.clearResults()
end

function SetValue(a, b, c)
  local set = {}
  local lib = gg.getRangesList(a)[1].start
  local Hex = hex2tbl(c)
  
  local V = {}
  for i = 1, #Hex do
    V[i] = tonumber(Hex[i], 16)
    if V[i] > 127 then
      V[i] = V[i] - 256
    end
  end
  
  if not SaveOFF[b] then
    local Z = {}
    for i = 1, #Hex do
      Z[i] = {
        address = lib + b + i - 1,
        flags = gg.TYPE_BYTE
      }
    end
    SaveOFF[b] = gg.getValues(Z)
  end
  
  local R = getValues(lib, b, #Hex)
  
  if R[1].value == V[1] and R[3].value == V[3] then
    gg.setValues(SaveOFF[b])
  else
    setValues(lib, b, V)
  end
end

SetValue("libil2cpp.so", 0x3938c3c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19b8198, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19b902c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19b9854, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19c8c78, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19c8e30, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19c8fa8, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19cd5a8, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x19e8934, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb1d0, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb26c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb300, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb550, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb71c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb7b4, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb984, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbbfd8, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6a50814, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6bbb304, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x6a5bd78, "00 00 80 D2 C0 03 5F D6")

SetValue("libil2cpp.so", 0x753f350, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x67b0880, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x67b096c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x753f44c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d68fbc, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d679c0, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d69b34, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d6a5d4, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d6a79c, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d6e418, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d6e020, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d6e124, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2d6eb94, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2e3b050, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2e3db70, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2e3a388, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2e3b050, "00 00 80 D2 C0 03 5F D6")
SetValue("libil2cpp.so", 0x2e3a18c, "00 00 80 D2 C0 03 5F D6")
gg.toast("Bypass loaded!")
function script()
main = gg.choice({
G.."Speed Hack ⏳",
F.."Nhảy Dù Nhanh 🪂",
"Menu Hành Động Lv7💎",
"Menu Aim🎯",
"Menu Định vị📡",
"Menu Bạo⛔",
"Thoát Script",
},nil,' Phát triển bởi @hnlsm [Telegram] ')
if main == nil then gg.toast('HNhat') else
if main == 1 then speed() end
if main == 2 then fast() end
if main == 3 then emote() end
if main == 4 then aim() end
if main == 5 then esp() end
if main == 6 then risk() end
if main == 7 then thoat() end
if main == 8 then gg.setVisible(true) os.exit(print('HNhat')) end
end end
G = " OFF "
function speed()
    if G == " OFF " then
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("h 01 00 00 00 02 2B 07 3D", gg.TYPE_BYTE)
        gg.getResults(gg.getResultsCount())
        gg.editAll("h 01 00 00 00 FC A9 71 3D", gg.TYPE_BYTE)
        gg.toast("Speed hack ON✅")
        gg.clearResults()
        G = " ON "
    elseif G == " ON " then
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("h 01 00 00 00 FC A9 71 3D", gg.TYPE_BYTE)
        gg.getResults(gg.getResultsCount())
        gg.editAll("h 01 00 00 00 02 2B 07 3D", gg.TYPE_BYTE)
        gg.toast("Speed hack OFF❌")
        gg.clearResults()
        G = " OFF "
    end
end
F = " OFF "
function fast()
if F == " OFF " then
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("h 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 80 7F 00 00 80 7F 00 00 80 7F 00 00 80 FF", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("h 00 00 00 00 00 00 FF 41 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 FF 41 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 80 7F 00 00 80 7F 00 00 80 7F 00 00 80 FF", gg.TYPE_BYTE)
gg.toast("Bung dù nhanh ON ✅")
gg.clearResults()
F = " ON "
elseif F == " ON " then
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("h 00 00 00 00 00 00 FF 41 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 FF 41 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 80 7F 00 00 80 7F 00 00 80 7F 00 00 80 FF", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("h 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 80 BF 00 00 00 00 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 80 BF 00 00 80 7F 00 00 80 7F 00 00 80 7F 00 00 80 FF", gg.TYPE_BYTE)
gg.toast("Bung dù nhanh OFF ❌")
gg.clearResults()
F = " OFF "
    end
end
function emote()
skinsung = gg.multiChoice({
'Ak rồng xanh',
'Scar cá mập đen',
'Mp40 mãng xà',
'M1014 long tộc',
'Xm8 lôi thần',
'Ump phong cách',
'Fmas quỷ doạ xoa',
'Mp5 thiên thần bạch kim',
'M1887 vũ trụ hủy diệt',
'M4a1 hoả ngục',
'Nắm đấm long trảo quyền',
'An94 tiếng hú ác quỷ',
'Thompson hắc long',
'M1014 huyết hoả',
'Mp40 tia chớp tử thần',
'Groza địa chấn sắc màu',
'Chim gõ kiến mãnh hổ oai hùng',
'Parafal cuồng long',
'G18 chinh phục',
'Return',
},nil,'Bắt buộc phải có hành động bất kỳ và tải skin súng Nâng Cấp trước khi dùng')
if skinsung == nil then gg.toast(' HNhat') else
if skinsung [1] then skinak47() end
if skinsung [2] then skinscar() end
if skinsung [3] then skinmp40() end
if skinsung [4] then skinm1014() end
if skinsung [5] then skinxm8() end
if skinsung [6] then skinump() end
if skinsung [7] then skinfmas() end
if skinsung [8] then skinmp5() end
if skinsung [9] then skinm1887() end
if skinsung [10] then skinm4a1() end
if skinsung [11] then skinndlongtrao() end
if skinsung [12] then skinan94() end
if skinsung [13] then skinthompson() end
if skinsung [14] then skinm1014hh() end
if skinsung [15] then skinmp40tc() end
if skinsung [16] then skingroza() end
if skinsung [17] then skinchimgokien() end
if skinsung [18] then skinparafal() end
if skinsung [19] then sking18() end
if skinsung [20] then gg.setVisible(true) end
end end
function skinak47()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000063", gg.TYPE_DWORD)
    gg.clearResults()
gg.toast("Ak rồng xanh✅")
end
function skinscar()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000068", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Scar cá mập đen✅")
    end
function skinmp40()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000075", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Mp 40 mãng xà✅")
    end
function skinm1014()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000081", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("M1014 long tộc✅")
    end
function skinxm8()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000085", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Xm8 lôi thần✅")
    end
function skinump()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000098", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Ump phong cách✅")
    end
function skinfmas()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909000090", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Fmas quỷ doạ xoa✅")
    end
function skinmp5()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909033002", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Mp5 thiên thần bạch kim✅")
    end
function skinm1887()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909035007", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("M1887 vũ trụ hủy diệt ✅")
    end
function skinm4a1()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909033001", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("M4a1 hoả ngục✅")
    end
function skinndlongtrao()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909037011", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Nắm đấm long trảo quyền✅")
   end
function skinan94()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909035012", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("An94 tiếng hú ác quỷ✅")
    end
function skinthompson()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909038010", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Thompson hắc long✅")
    end
function skinm1014hh()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909039011", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("M1014 huyết hoả✅")
     end
function skinmp40tc()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909040010", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Mp 40 tia chớp tử thần✅")
    end
function skingroza()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909041005", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Groza địa chấn sắc màu✅")
    end
function skinchimgokien()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909042008", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Chim gõ kiến mãnh hổ oai hùng✅")
    end
function skinparafal()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909045001", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("Parafal cuồng long✅")
    end
function sking18()
gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("909000001~909047020", gg.TYPE_DWORD)
    gg.getResults(10000000)
    gg.editAll("909038012", gg.TYPE_DWORD)
    gg.clearResults()
      gg.toast("G18 chinh phục✅")
    end
function aim()
m = gg.multiChoice({
'Aim awm (Sảnh/Đăng nhập)',
'Đổi tỉa nhanh (Sảnh/Đăng nhập)',
'Nhẹ tâm (Sảnh/Đăng nhập)',
'Headshot mỗi bụng (Trong trận)',
'Magic Bullet (Sảnh/Đăng nhập)',
'Quay về',
})
if m == nil then gg.toast('HNhat') else
if m [1] then awm() end
if m [2] then fastsw() end
if m [3] then nhead() end
if m [4] then hsb() end
if m [5] then magic() end
if m [6] then gg.setVisible(true) end
end end
function awm()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("h 08 00 00 00 00 00 60 40 CD CC 8C 3F 8F C2 F5 3C CD CC CC 3D 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 3F 33 33 13 40 00 00 B0 3F 00 00 80 3F 01", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("h 08 00 00 00 00 00 60 40 CD CC 8C 3F 8F C2 F5 3C CD CC CC 3D 06 00 00 00 00 00 80 3F 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 33 33 13 40 00 00 B0 3F 00 00 80 4F 01", gg.TYPE_BYTE)
gg.clearResults()
gg.toast("Xong ✅")
end
function fastsw()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("h B4 42 96 00 00 00 00 00 00 00 00 00 00 3F 00 00 80 3E 00 00 00 00 04 00 00 00 00 00 80 3F 00 00 20 41 00 00 34 42 01", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("h B4 42 96 00 00 00 00 00 00 00 00 00 00 3B 00 00 80 3B 00 00 00 00 04 00 00 00 00 00 80 3F 00 00 20 41 00 00 34 42 01", gg.TYPE_BYTE)
gg.clearResults()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("h 5C 43 00 00 28 42 00 00 B4 42 78 00 00 00 00 00 00 00 9A 99 19 3F 00 00 80 3E 00 00 00 00 04 00 00 00 00 00 80 3F 00 00 20 41 00 00 34 42 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 80 3F", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("h 5C 43 00 00 28 42 00 00 B4 42 78 00 00 00 00 00 00 00 9A 99 19 3C 00 00 F5 3C 00 00 00 00 04 00 00 00 00 00 80 3F 00 00 20 41 00 00 34 42 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 80 3F", gg.TYPE_BYTE)
gg.clearResults()
gg.toast("Xong ✅")
end
function nhead()
gg.setRanges(32)
gg.searchNumber("h1000000062006F006E0065005F004C006500660074005F0057006500610070006F006E00",1)
gg.getResults(10000)
gg.editAll("h1000000062006F006E0065005F0048006500610064000000000000000000000000000000",1)
gg.clearResults()
gg.setRanges(32)
gg.searchNumber("h4C7B5ABD0A5766BB1E2148BA2AC2CF3B96FB283DE8B117BDE3997F3F0400803F0100803FFCFF7F3F",1)
gg.getResults(10000)
gg.editAll("hD10AC0BE16DC98BDBB8297B400000000BFB22F3F4332733666037B35721CC73F721CC73F721CC73F",1)
gg.clearResults()
gg.setRanges(32)
gg.searchNumber("h23AAA6B8460ACD70",1)
gg.getResults(10000)
gg.editAll("h23AAA6B8B2F71FA4",1)
gg.clearResults()
gg.toast("Xong ✅")
end
function hsb()
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER)
gg.searchNumber("hdc5239bd27c18b3cc0d0f8b9", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("hdc52393e27c18b3cc0d0f8bc", gg.TYPE_BYTE)
gg.clearResults()
gg.searchNumber("h6371b0bd909874bb", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("hcddc7944909874b9", gg.TYPE_BYTE)
gg.clearResults()
gg.searchNumber("h7bf96cbd583409bbb060beba", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("hcddc7944583409bbb060beba", gg.TYPE_BYTE)
gg.clearResults()
gg.toast("Xong ✅")
end
function magic()
gg.setRanges(32)
gg.searchNumber("h23AAA6B8460ACD70", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h23AAA6B8B2F71FA4", 1)
gg.clearResults()
gg.searchNumber("h477B5ABDAE5766BB5C1F48BA1BC0CF3B9CFB283DA2B117BDE4997F3F0400803F0000803FFEFF7F3F", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h8D07743FAE5766BB5C1F48BA1BC0CF3B9CFB283DA2B117BDE4997F3F000060410000604100006041", 1)
gg.clearResults()
gg.searchNumber("h4C7B5ABD0A5766BB1E2148BA2AC2CF3B96FB283DE8B117BDE3997F3F0400803F0100803FFCFF7F3F", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h1B0E743FAE5766BB5C1F48BA1BC0CF3B9CFB283DA2B117BDE4997F3F000060410000604100006041", 1)
gg.clearResults()
gg.searchNumber("h1000000062006F006E0065005F004C006500660074005F0057006500610070006F006E00", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h1000000062006F006E0065005F005300700069006E006500000000000000000000000000", 1)
gg.clearResults()
gg.toast("Xong ✅")
end
function esp()
gps = gg.multiChoice({
'Antenna Đầu (Đăng nhập)',
'Antenna Tay (Đăng nhập)',
'Antenna Cổ (Đăng nhập)',
'Antenna Vai (Đăng nhập)',
'Định Vị Đồ (Trong trận)',
'Quay về',
})
if gps == nil then gg.toast('HNhat') else
if gps [1] then head() end
if gps [2] then hand() end
if gps [3] then neck() end
if gps [4] then shoulder() end
if gps [5] then random() end
if gps [6] then gg.setVisible(true) end
end end
function head()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber('5.9762459e-7;1::5 ', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.searchNumber('7.5538861e-7;1::5', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.toast('Xong ✅')
end
function hand()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber('-0.02980032004;1;0.48141112924::9', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.searchNumber('0.09043131769;1;0.14753369987::9', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.toast('Xong ✅')
end
function neck()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber('7.15025408e-8;1::5', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.searchNumber('3.93490495e-7;1::5', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.toast('Xong ✅')
end
function shoulder()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber('-0.30576485395;0.01430506539;-0.73534429073;1::13', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.searchNumber('-0.2212036103;0.03038031235;-0.76885718107;1::13', gg.TYPE_FLOAT)
gg.refineNumber('1', gg.TYPE_FLOAT)
gg.getResults(gg.getResultsCount())
gg.editAll('3000', gg.TYPE_FLOAT)
gg.clearResults()
gg.toast('Xong ✅')
end
function random()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("h 19 00 00 00 69 00 6E 00 67 00 61 00 6D 00 65 00 2F 00 70 00 69 00 63 00 6B 00 75 00 70 00 2F 00 70 00 69 00 63 00 6B 00 75 00 70 00 5F 00 62 00 6D 00 39 00 34 00 00 00", gg.TYPE_BYTE)
gg.getResults(gg.getResultsCount())
gg.editAll("h 19 00 00 00 65 00 66 00 66 00 65 00 63 00 74 00 73 00 2F 00 76 00 66 00 78 00 5F 00 69 00 6E 00 67 00 61 00 6D 00 65 00 5F 00 6C 00 61 00 73 00 65 00 72 00 00 00 00 00", gg.TYPE_BYTE)
gg.clearResults()
gg.toast("Xong ✅")
end
function risk()
x = gg.multiChoice({
'Người trắng + Trời đen (Đăng nhập) ',
'Xuyên đá (Sảnh/Đăng nhập)',
'Xuyên keo (Sảnh/Đăng nhập)',
'Camera xa (Sảnh/Đăng nhập)',
'Quay vể',
})
if x == nil then gg.toast('HNhat') else
if x [1] then mau2() end
if x [2] then stone() end
if x [3] then keo() end
if x [4] then cam() end
if x [5] then gg.setVisible(true) end
end end
function mau2()
gg["setRanges"](gg.REGION_VIDEO)
gg["searchNumber"]("1072216622", 4)
gg["getResults"](gg["getResultsCount"]())
gg["editAll"]("1147786543", 4)
gg["clearResults"](gg["getResultsCount"]())
gg["searchNumber"]("h 00 00 70 40 00 00 00 3F", 1)
gg["getResults"](gg["getResultsCount"]())
gg["editAll"]("h 00 00 70 40 66 66 48 42", 1)
gg["clearResults"](gg["getResultsCount"]())
gg.toast("Xong ✅")
end
function stone()
gg.setRanges(gg.REGION_CODE_APP)
gg.searchNumber("-6.11142992e27", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1, 0)
gg.getResultsCount()
gg.getResults(gg.getResultsCount())
gg.editAll("0", gg.TYPE_FLOAT)
gg.clearResults()
gg.toast("Xong ✅")
end
function keo()
gg.setRanges(gg.REGION_ANONYMOUS)
local searchValue = "7209065;6357095;6619245;6357039;7536755;7536745;6357108;7602286;7602281;7143525;6881327;6619235;6357111;7077996;6422623;7209077;6619243;114:69"
local editValue = ";effects/vfx_pet/vfx_petskill_robot"
gg.searchNumber(searchValue, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
local results = gg.getResults(99999)
if #results > 0 then
gg.editAll(editValue, gg.TYPE_DWORD)
gg.toast("✅ Keo tàn hình bật")
else 
    gg.alert("❌ Không tìm thấy kết quả")
    end
end
function cam()
gg.setRanges(gg.REGION_ANONYMOUS)
gg.searchNumber("1;0;0;-1;0;-1;0;0;1;0;0;0;0;1::53", gg.TYPE_FLOAT)
gg.refineNumber("1", gg.TYPE_FLOAT)
gg.getResults(3)
gg.editAll("1;1;1.9", gg.TYPE_FLOAT)
gg.clearResults()
gg.searchNumber("2;0;0;-1;0;-1;0;0;1;0;0;0;0;1::53", gg.TYPE_FLOAT)
gg.refineNumber("1", gg.TYPE_FLOAT)
gg.getResults(2)
gg.editAll("1;1.9", gg.TYPE_FLOAT)
gg.clearResults()
gg.toast('Xong ✅')
end
function thoat()
  print("Goodbye see you later")
  print("                            ")
  print("                           ")
  print("Thank You For Using My Script ")
  print("Credit: Hủy Diệt Đàn Gà @hnlsm ")
  print("Telegram: t.me/lsModgaming (Loadstring Mod)                     ")
  os.exit()
end
while true do if gg.isVisible() then gg.setVisible(false) script() end end