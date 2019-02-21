//
//  MockupGetDevices.swift
//  GrinChallenge
//
//  Created by Stephane Gardon on 2/18/19.
//  Copyright © 2019 Stephane Gardon. All rights reserved.
//

import Foundation

func getDevicesMU() -> AnyObject{
    var dico =  [AnyObject]()
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec5a90b7eecf517ebcf51c"
        el["name"] = "device1"
        el["address"] = "00:11:22:33:FF:EE"
        el["strength"] = "-20db"
        el["created_at"] = "2019-02-18T22:11:42.056Z"
        return el as AnyObject
        } as () -> AnyObject)() )
    
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec5aa1b7eecf517ebcf51e"
        el["name"] = "device1"
        el["address"] = "00:11:22:33:FF:44"
        el["strength"] = "-20db"
        el["created_at"] = "2019-02-18T07:27:58.676Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec63c1b729690015ef54b9"
        el["name"] = "LE-reserved_N"
        el["address"] = "6F:10:18:A2:8B:A2"
        el["strength"] = "-87dBm"
        el["created_at"] = "2018-11-14T18:45:53.855Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec6500fbf70300150b0c78"
        el["name"] = "LE-reserved_N"
        el["address"] = "6F:10:18:A2:8B:A3"
        el["strength"] = "-87dBm"
        el["created_at"] = "2018-11-14T18:52:01.351Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec6d6dbabb6400157a6cbd"
        el["name"] = "LE-reserved_N"
        el["address"] = "6F:10:18:A2:8B:B6"
        el["strength"] = "-87dBm"
        el["created_at"] = "2018-11-14T23:15:08.004Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec85394a48b10015ba2d60"
        el["name"] = "XMZ12181"
        el["address"] = "B8:86:87:BD:94:BE"
        el["strength"] = "-73dBm"
        el["created_at"] = "2018-11-14T20:27:37.550Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec860d4a48b10015ba2d61"
        el["name"] = "MB48393"
        el["address"] = "44:03:2C:A1:BB:0B"
        el["strength"] = "-76dBm"
        el["created_at"] = "2018-11-14T20:49:36.434Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec89084a48b10015ba2d64"
        el["name"] = "M54120-"
        el["address"] = "F8:59:71:85:18:61"
        el["strength"] = "-64dBm"
        el["created_at"] = "2018-11-14T23:22:29.957Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bec93a44a48b10015ba2d6b"
        el["name"] = "M40929"
        el["address"] = "48:51:B7:95:48:08"
        el["strength"] = "-85db"
        el["created_at"] = "2018-11-14T21:29:08.144Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5beca23f4a48b10015ba2d6c"
        el["name"] = "XM060AA"
        el["address"] = "D0:57:7B:0A:76:01"
        el["strength"] = "-84db"
        el["created_at"] = "2018-11-14T22:31:27.234Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5becae35d1e5170016c0c67b"
        el["name"] = "MB80078LNX"
        el["address"] = "14:AB:C5:C4:D7:B2"
        el["strength"] = "-60db"
        el["created_at"] = "2018-12-12T00:57:08.462Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5befbe3996421300165f5af7"
        el["name"] = "Device 2"
        el["address"] = "00:00:00:00:00:00"
        el["strength"] = "-91dBm"
        el["created_at"] = "2018-11-17T07:18:26.055Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bf0747c57f2e3001615afec"
        el["name"] = "Gustavo’s MacBook Pro"
        el["address"] = "D0:A6:37:EF:D0:80"
        el["strength"] = "-47 dBm"
        el["created_at"] = "2018-11-18T08:37:44.175Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bf07f3f7a4b48001640bc16"
        el["name"] = "VBH1"
        el["address"] = "1C:52:16:99:AD:07"
        el["strength"] = "-46 dBm"
        el["created_at"] = "2018-11-17T20:51:11.348Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5bfbfd6a47aeff00168223c8"
        el["name"] = "Redmi"
        el["address"] = "20:47:DA:BD:CC:89"
        el["strength"] = "-87"
        el["created_at"] = "2018-11-26T14:04:27.064Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c10a6ce103b1d0016fe1785"
        el["name"] = "[TV] Home"
        el["address"] = "C0:97:27:00:85:E9"
        el["strength"] = "-69db"
        el["created_at"] = "2018-12-12T06:12:30.047Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c1dc1489525e70016289760"
        el["name"] = "[TV]Samsung LED50"
        el["address"] = "C4:57:6E:3C:6F:15"
        el["strength"] = "-80 db"
        el["created_at"] = "2018-12-22T04:44:56.749Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c201ec565c55e00168c4941"
        el["name"] = "[LG] webOS TV UJ6560"
        el["address"] = "44:07:4E:4F:DB:3D"
        el["strength"] = "-71dBm"
        el["created_at"] = "2018-12-23T23:48:21.103Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c22ff58788ad10016d21b9a"
        el["name"] = "unknown"
        el["address"] = "6E:B9:2E:3D:61:09"
        el["strength"] = "-88dBm"
        el["created_at"] = "2018-12-26T04:11:04.418Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c23c971a37e0b0016fe750e"
        el["name"] = "device1"
        el["address"] = "00:11:22:44:FF:EE"
        el["strength"] = "-20db"
        el["created_at"] = "2018-12-26T18:39:48.676Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c2498bd34b2580016e42796"
        el["name"] = "UE BOOM 2"
        el["address"] = "88:C6:26:E9:97:72"
        el["strength"] = "-89dBm"
        el["created_at"] = "2018-12-27T20:44:24.631Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c2498c834b2580016e42797"
        el["name"] = "UE MEGABOOM"
        el["address"] = "C0:28:8D:5C:0D:EC"
        el["strength"] = "-80dBm"
        el["created_at"] = "2018-12-27T20:44:24.826Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c26d1d9e11f340016177a6c"
        el["name"] = "ZTE BLADE V8 SE"
        el["address"] = "54:09:55:85:1A:CF"
        el["strength"] = "-78dBm"
        el["created_at"] = "2018-12-29T01:46:01.435Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c337cacc11be70016080201"
        el["name"] = "Habitacion chicos"
        el["address"] = "7C:C0:3E:ED:B9:96"
        el["strength"] = "-78dbm"
        el["created_at"] = "2019-01-07T16:26:23.182Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c339daeb8a3350016ae52b2"
        el["name"] = "Habitacion chicos"
        el["address"] = "58:18:78:9F:DA:5D"
        el["strength"] = "-75dbm"
        el["created_at"] = "2019-01-07T18:42:54.347Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c33d4f38a1ecd001613d04a"
        el["name"] = "Unknow Device "
        el["address"] = "79:CD:F7:B7:1E:B1"
        el["strength"] = "-59dbm"
        el["created_at"] = "2019-01-07T22:38:43.786Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c35102e19067d0016a62488"
        el["name"] = "Unknow Device "
        el["address"] = "77:83:94:54:2D:7D"
        el["strength"] = "-98dbm"
        el["created_at"] = "2019-01-08T21:03:42.670Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c353caea195f70016a6f728"
        el["name"] = "Unnamed device"
        el["address"] = "55:9F:03:F9:31:75"
        el["strength"] = "-85"
        el["created_at"] = "2019-01-09T00:13:35.070Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c353cb1a195f70016a6f729"
        el["name"] = "Unnamed device"
        el["address"] = "45:8A:CC:DE:4E:C6"
        el["strength"] = "-68"
        el["created_at"] = "2019-01-09T00:16:42.675Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c353d68a195f70016a6f72a"
        el["name"] = "Unknow Device "
        el["address"] = "59:65:6B:79:F5:F9"
        el["strength"] = "-71dbm"
        el["created_at"] = "2019-01-09T00:24:36.666Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c353d6ca195f70016a6f72c"
        el["name"] = "Unknow Device "
        el["address"] = "24:B1:6B:52:B7:C8"
        el["strength"] = "-74dbm"
        el["created_at"] = "2019-01-09T00:24:37.601Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c3d7b8ad5dc200016181806"
        el["name"] = "HT1003X16"
        el["address"] = "22:22:9E:AE:F3:EB"
        el["strength"] = "-57db"
        el["created_at"] = "2019-01-15T06:19:54.663Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c3e73b2f9d1f500163b93aa"
        el["name"] = "Unknown"
        el["address"] = "50:72:8A:22:BF:25"
        el["strength"] = "-65db"
        el["created_at"] = "2019-01-15T23:58:42.371Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4481b48409120016d614d1"
        el["name"] = "MB-E15-"
        el["address"] = "7C:04:D0:BC:CA:1D"
        el["strength"] = "-54"
        el["created_at"] = "2019-01-20T14:25:01.662Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4482128409120016d614d2"
        el["name"] = "Redmi"
        el["address"] = "70:3A:51:0D:77:56"
        el["strength"] = "-48"
        el["created_at"] = "2019-01-20T14:23:45.026Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4484898409120016d614d5"
        el["name"] = "MI Band 2"
        el["address"] = "DC:2E:EE:48:4B:13"
        el["strength"] = "-67"
        el["created_at"] = "2019-01-20T14:24:09.694Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c449acfe7b8f90016b186e9"
        el["name"] = "AirPods"
        el["address"] = "80:82:23:E0:E2:C2"
        el["strength"] = "0.0"
        el["created_at"] = "2019-01-20T16:43:11.931Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c44a2f4e7b8f90016b186eb"
        el["name"] = "Chevy MyLink"
        el["address"] = "A0:6F:AA:D7:37:DC"
        el["strength"] = "0.0"
        el["created_at"] = "2019-01-20T16:43:16.181Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c44a528e7b8f90016b186ee"
        el["name"] = "UE Mobile Boombox"
        el["address"] = "00:0D:44:A3:9D:1B"
        el["strength"] = "0.0"
        el["created_at"] = "2019-01-20T16:43:23.908Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c44cf04cdf65500168d3b01"
        el["name"] = "HUAWEI P20 lite"
        el["address"] = "C0:F4:E6:6C:C1:B7"
        el["strength"] = "-49"
        el["created_at"] = "2019-01-20T19:41:56.673Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4b836cdd7ff4001671b408"
        el["name"] = "Unknown"
        el["address"] = "C8:D0:83:D3:E4:9D"
        el["strength"] = "-74db"
        el["created_at"] = "2019-01-25T21:45:16.209Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4b836cdd7ff4001671b409"
        el["name"] = "Unknown"
        el["address"] = "64:38:AA:C4:AF:E6"
        el["strength"] = "-68db"
        el["created_at"] = "2019-01-25T21:45:16.159Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4b8375dd7ff4001671b40b"
        el["name"] = "LE-Bose SoundSport Free"
        el["address"] = "28:11:A5:1C:52:76"
        el["strength"] = "-63db"
        el["created_at"] = "2019-01-25T21:45:25.517Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c4febb29e5f500016584e9b"
        el["name"] = "Pruebas nuevas"
        el["address"] = "00:11:0:00:00:00"
        el["strength"] = "-50db"
        el["created_at"] = "2019-01-29T05:59:14.643Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c5642c1bc5f850016beb5cb"
        el["name"] = "Jonathan123"
        el["address"] = "00:25:25:25:25:25"
        el["strength"] = "-50db"
        el["created_at"] = "2019-02-03T01:24:17.082Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c5646bdbc5f850016beb5cc"
        el["name"] = "Sala"
        el["address"] = "DC:56:E7:44:A0:79"
        el["strength"] = "DC:56:E7:44:A0:79"
        el["created_at"] = "2019-02-03T01:41:17.579Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c566dcb9b9a820016c80f94"
        el["name"] = "Desconocido"
        el["address"] = "74:CD:69:70:E8:1D"
        el["strength"] = "-97dBm"
        el["created_at"] = "2019-02-03T04:27:55.153Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c568313d6180b0016b10d46"
        el["name"] = "Desconocido"
        el["address"] = "68:D9:3C:86:17:4A"
        el["strength"] = "-91dBm"
        el["created_at"] = "2019-02-05T03:18:54.849Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c5900cb86f5a300162c1b18"
        el["name"] = "Desconocido"
        el["address"] = "6C:94:F8:E3:D0:7D"
        el["strength"] = "-83dBm"
        el["created_at"] = "2019-02-05T03:19:40.010Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c59014e86f5a300162c1b19"
        el["name"] = "XBR-65X850E"
        el["address"] = "D4:6A:6A:6D:31:98"
        el["strength"] = "-96dBm"
        el["created_at"] = "2019-02-05T03:21:50.743Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c5a265d8136790016a79e97"
        el["name"] = "LE-Poncho's Bose"
        el["address"] = "04:52:C7:0A:10:73"
        el["strength"] = "-54dBm"
        el["created_at"] = "2019-02-06T00:15:00.689Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c5e387094cf410016b87c94"
        el["name"] = "iMac de Angel"
        el["address"] = "28:F0:76:2D:18:1F"
        el["strength"] = "-100 dBm"
        el["created_at"] = "2019-02-09T17:18:04.407Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    dico.append( ({
        var el = [String:String]()
        el["_id"] = "5c6b2e87166c2b00167e745c"
        el["name"] = "LG CM2760(EA)"
        el["address"] = "08:EF:3B:D7:32:EA"
        el["strength"] = "-21db"
        el["created_at"] = "2019-02-18T22:24:09.081Z"
    return el as AnyObject
        } as () -> AnyObject)() )
    
    return dico as AnyObject
}
