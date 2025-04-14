//
//  File.swift
//  Swift-ADS-B-Statistics
//
//  Created by Christopher Fridlington on 4/13/25.
//

import Foundation
import Testing
@testable import Swift_ADS_B_Statistics

@Suite
class ManufactuerRegistryTests {
    
    var aircraftRegistry = AircraftRegistry(history: [:], lastUpdated: 0)
    let path = Bundle.module.resourcePath
    
    @Test(arguments: zip(["history_small.json", "history_large.json"], [1, 50]))
    func createRegistry(filename: String, manufacturerCount: Int) async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        aircraftRegistry.importRegistry(fromDirectory: unwrappedPath, filename: filename)
        
        var manufacturerRegistry = ManufacturerRegistry()
        manufacturerRegistry.importAircraft(fromRegistry: aircraftRegistry)
        
        #expect(manufacturerRegistry.manufacturers.count == manufacturerCount)
    }
    
    @Test
    func frequentTypes() async throws {
        
        let unwrappedPath = try #require(path, "Test data not found")
        aircraftRegistry.importRegistry(fromDirectory: unwrappedPath, filename: "history_large.json")
        
        var manufacturerRegistry = ManufacturerRegistry()
        manufacturerRegistry.importAircraft(fromRegistry: aircraftRegistry)
        
        print(manufacturerRegistry.manufacturers.count)
        
        let frequentTypes = Array(manufacturerRegistry.getFrequentTypes()[0..<10])
        
        let expectedFrequentTypes: [Swift_ADS_B_Statistics.AircraftType] = [
            Swift_ADS_B_Statistics.AircraftType(name: "777 367ER", icao: "B77W", aircraft: ["780204", "c0174f", "89644e", "710107", "a2b8db", "06a070", "06a2b3", "710112", "a9a750", "76cee2", "406590", "406591", "4ba959", "71c346", "4b191c", "4ba945", "a9ab07", "896452", "780205", "4bb141", "406948", "394a04", "71ba05", "76cee7", "a9d640", "8015a6", "06a2c4", "89644f", "484cbc", "a9d9f7", "780a16", "394a0a", "407995", "a21dc4", "a9cb18", "710121", "800584", "01013c", "8964a5", "394a15", "896450", "a1c82a", "896455", "06a2b4", "71c347", "c02cf1", "4b191a", "40621d", "89649f", "710119", "70605d", "a1cb0f", "706056", "406947", "89644b", "76ceea", "780220", "710111", "a999d2", "406b05", "780a18", "3965b0", "76cee8", "4b1916", "a2b501", "76cef5", "4bb143", "4ba949", "484560", "71c042", "a2659a", "71c007", "010153", "71ba03", "4ba947", "06a1bf", "4bb147", "4065de", "394a02", "780a3c", "4ba953", "4bb144", "3965a0", "78023e", "4ba94a", "a9b62c", "71c006", "3965a3", "76ceed", "a290d0", "4ba94c", "407993", "4ba956", "394a08", "c01734", "71c009", "a9aebe", "78023d", "4ba94e", "06a07a", "8964a3", "8964a0", "010154", "a9cecf", "c01753", "48455e", "8015a7", "484cba", "06a2b5", "06a2b2", "76cee9", "4ba94f", "71010f", "a21633", "780a61", "710110", "a9c508", "4b1918", "76cef0", "71c008", "8964a1", "76cef7", "407992", "06a19f", "06a1bc", "3965a4", "a9bd9a", "7100c8", "4bb14a", "a9b9e3", "394a09", "8015a8", "01013d", "4ba950", "3965b1", "80159f", "4bb145", "a9b275", "a1f5ff", "71ba04", "a9ddb0", "406b0a", "394a18", "a1c7c1", "406a35", "76cef6", "4b1921", "394a01", "407994", "06a2b1", "4ba94b", "71ba02", "a9c151", "7103d8", "4b1917", "4b191d", "4ba946", "4bb148", "a9a399", "76cef2", "71c011", "800c3e", "3965a1", "3965b3", "a2b8fe", "40621b", "a290f3", "780a89", "896454", "76cdc3", "a1f2b1", "76cdc1", "a9e167", "4ba954", "484561", "06a2c7", "a21679", "8964a8", "70605f", "406a34", "48455f", "394a00", "06a2b6", "71c010", "8964a4", "394a12", "394a05", "780a17", "76cefa", "70605e", "a1c7e4", "780a3b", "4ba94d", "70605c", "a99d89", "394a06", "4b1919", "4bb142", "780a19", "40621c", "a1cac9", "06a2c6", "06a071", "4bb14b", "394a07", "a219ea", "800582", "06a2af", "06a069", "71c041", "76ceef", "8004e0", "3965a9", "4ba955", "06a1be", "06a2c5", "a2e014", "06a2b7", "06a1c0", "4ba95a", "394a0c", "394a0b", "a9d286", "706058", "70605b", "06a2b8", "4ba952"], lastSeen: 1744514646.3), Swift_ADS_B_Statistics.AircraftType(name: "787 9", icao: "B789", aircraft: ["a43100", "406f76", "406d7b", "407371", "c010a8", "406d79", "a0eeea", "a09fc4", "4bb196", "ab5257", "406f79", "4bb194", "4bb182", "406c3b", "48ae26", "a560f3", "c0293e", "47b217", "8965f4", "4851af", "a254f7", "0101db", "0101dc", "0d09ec", "4bb189", "86eb36", "4bb185", "7380c7", "a13de2", "7380c9", "406c39", "7380c5", "7380c2", "47b1dc", "406d4d", "040141", "ab3c0d", "86e452", "7380c3", "0101df", "ab7fe6", "406c3a", "7380c1", "86e4da", "4bb195", "40787b", "c023c5", "0101e0", "406b4a", "406b48", "4851b0", "39c429", "4073ce", "406b49", "86e4b8", "48ae20", "39c426", "ab349f", "406ecc", "48ae23", "4bb19a", "c02fb8", "4bb184", "7380cb", "406d78", "48ae22", "ab7613", "4bb18d", "0101dd", "39c420", "406f72", "406d7a", "47b0e7", "0d0a9b", "ab6ea5", "7380ca", "7380c0", "c038aa", "7380c4", "c02ee9", "c023c9", "0d0a9a", "8963ce", "7380c6", "4851ad", "40745e", "4bb18f", "c038a7", "86e3ec", "86eb14", "4bb188", "4851b1", "4bb183", "4bb190", "0d09d0", "39c422", "86e474", "4bb186", "8963cf", "4bb1a2", "a2a3af", "8964bb", "406e11", "406e0f", "c0103a", "39c427", "c02ec7", "406f77", "c02ec1", "a31a54", "78158f", "ab4e94", "4bb193", "a31a77", "8965f5", "40749b", "86e430", "40787a", "485788", "ab6afa", "ab4ae9", "040188", "ab4732", "780c58", "34558f", "7380c8", "406f73", "a2a3d2", "ab5c12", "a07176", "86e496", "47c98d", "a14bdd", "8964c0", "c038ac", "39c424", "40742e", "ab839d", "48ae21", "406f7a", "ab3fc4", "4bb187", "a540e2", "407131", "c01040", "a2f2fa", "c02eb9", "4851ae", "485789", "4bb18a", "0d0ed6", "c080dd", "48ae24", "c0103e", "a2cb33", "c02ed9", "c038a3", "ab5867", "3c4a02", "ab6737", "4bb199", "78110d", "ab6380", "c01074", "89640a", "4ca8fa", "ab436f", "c023c8", "4bb181", "4bb192", "7103d7", "ab5fc9", "c01049", "47b121", "8965f3", "406e10", "c02eca", "406d77", "4ca8fb", "4bb18b", "39c423", "896409", "ab30e6", "485344"], lastSeen: 1744508636.8999999), Swift_ADS_B_Statistics.AircraftType(name: "777 222ER", icao: "B772", aircraft: ["aac4ed", "aa1a16", "aab812", "aabf80", "4007f7", "a20433", "aa6bc0", "3949f0", "4007ed", "aa2ca9", "4007f0", "a1d18f", "4007f1", "400776", "aad213", "aa305f", "48436c", "a1d546", "4007fb", "aac337", "3949ef", "48436a", "a1aa10", "484369", "aa7082", "3949e3", "4005be", "a2007c", "aaa893", "a1f557", "4006c4", "4005c1", "400685", "484370", "aad3c9", "aa77f0", "4408fb", "4841ad", "aac6ee", "3949ec", "aa9d6e", "440002", "aa931d", "4007ee", "aa9bb8", "aac8a4", "4005bc", "aad780", "484416", "400772", "4006c1", "400773", "4005c0", "aace5c", "aa7439", "aacaa5", "aa253b", "aa57df", "4005bd", "405bfc", "400683", "aad012", "a1f1a0", "aaae4b", "a1f90e", "aa6ba4", "aa9801", "aabbc9", "aa9300", "aa92f9", "aaba9a", "4007f3", "aaaa92", "3949e0", "aad5ca", "aaa125", "440081", "48436e", "a75103", "aa92fc", "4007f6", "aab202", "400775", "aaa6dd", "440020", "a2a915", "400771", "aa92ff", "4005ba", "aa9f6f", "3949f8", "aa1dcd", "a1a2a2", "3949ea", "48436b", "48436f", "3949e9", "4006c3", "aa4440", "aaa326", "aa5f41", "484415", "aa6ccb", "4406de", "4843f3", "3949f9", "aa4548", "4007ef", "aa9093", "aa92f8", "aa6b9f", "4005bf", "a1fcc5", "405bfb", "400684", "4006c0", "aadb37", "aa2184", "aa8315", "aa92fa", "4007ec", "aa3417", "aa5b92", "aa99b7", "405bfd", "aa86cc", "4006c2", "400774", "aa28f2", "4007f4", "4007f5", "a43667", "3949eb", "aad981", "aa6db4", "aa6b9d", "aaac4a", "484371", "aacc5b", "aaa4dc", "aa3b85", "aa944a", "ab4ea9", "a1ede9", "aa7f5e", "aa92fb", "4007f2", "a92d6d", "aa6b7e", "400610", "3949ed", "a1b535", "4005b9", "4005bb", "aa4903", "4007fa", "aac136", "aa8a83", "3949e5", "aa4195", "aab001", "a9f502", "aa441c", "a1d8fd", "aabd7f", "3949e6", "aa7ba7", "aa9321"], lastSeen: 1744501947.9), Swift_ADS_B_Statistics.AircraftType(name: "A330 343X", icao: "A333", aircraft: ["c05840", "3c5b32", "3c6570", "44ccc8", "484f72", "c051e2", "4b187f", "4b187b", "4b187e", "4bb1c4", "44ccc7", "ab1979", "4b1880", "aae6d5", "3c6564", "40641d", "c04fe4", "3c656b", "3c6563", "4bb1c5", "4ba9da", "4ba9cb", "44ccd8", "3c656e", "4bb1c7", "ab0a9d", "ab40f8", "ab00d6", "4bb1c6", "4b1882", "3c68cb", "4b1884", "3c6573", "c04fbb", "4bb1c3", "4063e6", "4ba9cc", "484f73", "3c6568", "4bb46e", "ab15c2", "4850e6", "4ba9e7", "461f09", "4ca615", "344304", "4b1883", "3c656c", "4ba9cd", "478f5c", "40655d", "3c6572", "ab538b", "aaee43", "ab2c0c", "344346", "4b187d", "ab599b", "47c1c2", "4ba9e9", "ab120b", "4b187a", "4ca614", "4ba9ce", "44ccc5", "40683e", "ab4fd4", "c04fd7", "4b1885", "ab3d41", "478d42", "4ca5c7", "ab2855", "4066ab", "4caaf1", "aaf5b1", "3c6566", "ab1d30", "aaf1fa", "4caa41", "aaea8c", "ab048d", "3c5b31", "c053f6", "4b187c", "44ccca", "4ba9c9", "484fff", "4b1886", "4ba9e4", "461f06", "ab5d52", "406832", "344344", "3c6571", "4ba9e5", "4b1887", "478f47", "ab4c1d", "3c4ec7", "aaf968", "ab20e7", "407be2", "3c6561", "ab249e", "461f0d", "4ba9ca", "4ac8a8", "4ca74e", "407be6", "ab0e54", "406814", "ab4866", "4bb46d", "47880d", "461f08", "461f07", "4ca7d8", "344502", "ab321c", "4ba9d4", "ab44af", "478854", "ab35d3", "484f71", "44ccc3", "44ccc2", "4b1881", "344503", "3c6565", "ab398a", "344345", "4cabec", "461f0e", "aafd1f", "478f43", "3c6562", "4ba9ea", "4ba9d0", "4ba9e8"], lastSeen: 1744515904.8999999), Swift_ADS_B_Statistics.AircraftType(name: "CRJ 900 LR NG", icao: "CRJ9", aircraft: ["a75ac7", "a71e5c", "a700a4", "a3ad6d", "a19357", "a3245d", "a33aa7", "a30d18", "a71aa5", "a086ce", "a5f162", "aca79d", "a34825", "c01b6c", "a3c259", "a31486", "ac92b1", "a93d7c", "a08317", "a37e80", "a6152a", "a33339", "a1094c", "a70bc9", "acf69b", "acc040", "a1584a", "acddf8", "a3534a", "a7d725", "ad01c0", "a7a257", "a39113", "ace7bf", "a785fd", "a15795", "a09961", "a92ea0", "a7dec2", "a7b133", "a145b7", "ad046b", "aca3e6", "a34215", "a794d9", "a75710", "a15027", "a18380", "a72823", "a7cc00", "a14c70", "a7dadc", "a095aa", "ac83d5", "a7e24a", "a7e279", "a091f3", "a36fa4", "a7de93", "a61173", "a385ee", "ace1af", "a5fc87", "acb679", "a7db0b", "a08a85", "acfe09", "a7cfb7", "a15b4c", "a2af3e", "acc3f7", "a8f9a3", "a336f0", "a2000d", "a35e6f", "a34bdc", "accb65", "ac7c67", "a35ab8", "a3a9b6", "a5e02d", "a32bcb", "a39ada", "acda41", "a0ba4e", "a39723", "a305aa", "a30961", "a21142", "acc7ae", "a17c12", "acab54", "a38237", "acfa52", "a3b124", "a77d89", "a6ce58", "a130cb", "a36994", "a14502", "a3dc5a", "acaf0b", "acba30", "a7c849", "a08e3c", "a148b9", "a73e6d", "a7ad7c", "a153de", "acb2c2", "a32f82", "a33e5e", "a5e9f4", "a5e3e4", "a07f60", "a310cf", "a79890", "ac78b0", "a320a6", "a76d5a", "a75359", "a73348", "ac98c1", "a0be05", "ac8efa", "ac878c", "a6f6dd", "a7045b", "a8f235", "a76235", "a2fe3c", "a3e011", "accf1c", "aceb76", "aca02f"], lastSeen: 1744513273.0), Swift_ADS_B_Statistics.AircraftType(name: "767 34AF/W", icao: "B763", aircraft: ["a3c68c", "a05f59", "a4959a", "a0f46f", "a17b16", "a865e3", "a8a4c7", "a3defb", "44001e", "a120f3", "a880ff", "a13af4", "a06e35", "a8a110", "a1863b", "44003f", "a0f4a2", "a89234", "a875da", "a8699a", "a91b44", "a13748", "a05eb4", "a15ebc", "a5fef9", "a39f0d", "a18284", "a3ade9", "a3f1c2", "a884b6", "a07bb3", "a8ac35", "a8cffd", "a124b5", "a3b1a0", "a899a2", "a12c18", "a89d59", "a8c121", "a9178d", "a0f4f6", "c008c6", "c05857", "4cc278", "a17ecd", "a0563b", "a3d78d", "a324d9", "a87223", "a3c4d2", "a05ba2", "a13386", "a0851b", "a00ca4", "a8d3b4", "a8f77c", "a3f579", "a3d1b1", "4cc279", "a5b769", "a8c3bd", "a11d3c", "a12c23", "a8f3c5", "a15b05", "a8b5fc", "a12861", "a1775f", "a1286c", "a3e89a", "a11380", "a8a87e", "405f32", "a8bd6a", "a8e132", "a3aa32", "a451cb", "a13391", "a173a8", "a8c88f", "a8ec57", "a16883", "a8886d", "a0f44c", "a8bc4f", "a8f00e", "a1574e", "a8cc46", "a14104", "a16273", "a15397", "4cc27f", "a3376c", "a1f4c5", "a37b45", "a87876", "440060", "a86e6c", "a189f2", "a86ab5", "a8b9b3", "a3fce7", "a1373d", "c011b6", "a8dd7b", "a8c4d8", "a37020", "4005d4", "400b4b", "a8e8a0", "a8e4e9", "a45199", "a3f930", "a411d3", "a16c3a", "a8afec", "a8d76b", "a05614", "a895eb", "c03261", "a3bf1e", "a3d91f", "a3b90e", "a913d6", "a0f4b5", "a12fda"], lastSeen: 1744516089.0), Swift_ADS_B_Statistics.AircraftType(name: "A350 941", icao: "A359", aircraft: ["780a9b", "34754d", "789241", "789202", "4aca66", "a7563a", "3475c7", "3c6702", "76cce7", "39cf11", "8015f7", "76cda9", "3c670b", "3c6706", "a670a3", "a748bc", "a65449", "a641b6", "a661c7", "789242", "04021d", "789233", "06a10d", "3c670e", "39cf00", "040198", "76cdba", "4aca64", "347206", "780ab9", "4aca63", "780aaa", "06a0ea", "3c6701", "39d2a3", "06a10e", "39cf05", "39d2a0", "39cf0d", "a6745a", "76cdb5", "346057", "a6456d", "06a0e5", "a75283", "39d2a4", "76cce3", "34604e", "3c6707", "39cf12", "040203", "76cdb3", "a65800", "461f48", "780abb", "3c670c", "3c6705", "3c670f", "06a0e6", "a759f1", "3c6710", "3c6703", "39cf0f", "39c498", "39c48d", "347343", "347387", "39b493", "040173", "789243", "789234", "a66cf7", "3c66c2", "a74ecc", "a68336", "39c495", "3c6711", "39cf01", "39d2a5", "06a0e4", "3c66c1", "3c670d", "39cf07", "780ab8", "780aab", "39cf09", "76cce2", "3465c5", "75855b", "76cce5", "3c6709", "76cdb9", "3c66c3", "76cdb4", "780ac8", "06a0eb", "801612", "3c6708", "3c670a", "a65bb7", "39cf06", "347388", "789203", "461f50", "39c494", "3c66c4"], lastSeen: 1744490439.6000001), Swift_ADS_B_Statistics.AircraftType(name: "787 8", icao: "B788", aircraft: ["a59601", "ac142e", "507c59", "040127", "aaed0d", "738100", "ab1839", "48ae00", "020121", "740822", "ab10cb", "abf66c", "aae597", "0200ca", "a2ca5d", "507c54", "aa9bb7", "345251", "48ae06", "ac17e6", "040049", "40731c", "ab034d", "40688e", "a2ca5f", "aafbdf", "406d6f", "040047", "48ae03", "48ae02", "a2a2df", "a2a300", "ab1bf0", "ab236a", "ac308f", "ab2ad8", "aaf828", "80073f", "c058bb", "4067f8", "738101", "406a9f", "a2a2e3", "738103", "ac3448", "ad727c", "ac21af", "aae1ea", "ab1fa7", "740823", "507c55", "4067f6", "ac0906", "740825", "740827", "ac291f", "ab0969", "020123", "ac0cab", "507c4c", "ac2cb2", "0200cb", "040048", "a34358", "740821", "0d085d", "aae958", "ac0196", "4074e4", "740826", "ac1df7", "a1b5e7", "48ae04", "ad6ec5", "406a9e", "507c50", "738102", "48ae01", "406d70", "a2f200", "ab148e", "ac053f", "48ae07", "48506c", "aaf47d", "ab0d15", "abfa24", "ad6b0e", "a2ca64", "406890", "aaf0c6", "80073c", "040046", "406a9d", "a2a2e6", "406b12", "040123", "40688f", "c058bf", "3451cf", "406b13", "040045", "4067f5", "04004b"], lastSeen: 1744508503.3), Swift_ADS_B_Statistics.AircraftType(name: "A320 214", icao: "A320", aircraft: ["a1f11d", "780f4c", "4cc569", "a97310", "a87f51", "c06080", "a78945", "a2803d", "a2fe28", "a19e68", "a2da60", "a64996", "a21c53", "a2af2a", "a209c0", "a2f0aa", "a24789", "a1dc31", "a874e1", "a2e93c", "c00821", "a30596", "a17490", "aab2bf", "c03cf4", "a17fb5", "a43c7a", "4cc56e", "a2ecf3", "a1bac2", "a2200a", "a21ba0", "a24ef7", "a80d40", "a1a5d6", "a22778", "a27a2d", "a59197", "a8ce4f", "a263e3", "a1cd55", "a1c230", "a1836c", "a2cf3b", "a1d87a", "4d2332", "a31472", "aacf19", "a26f08", "a8c32a", "a1ed66", "a2be06", "a223c1", "a854d0", "a2e585", "c007d8", "c06e87", "a02088", "a301df", "a18723", "a27676", "a2f6ba", "a2e1ce", "a310bb", "a1ad44", "a17847", "a1696b", "4cc561", "a49232", "4cc564", "a85185", "a2de17", "a721a4", "a258be", "a7946a", "a1a21f", "a7bbe9", "a1a98d", "a1b0fb", "a06461", "a07341", "aaf183", "a226c5", "aac7ab", "a689b8", "a69894", "a24b40", "a18ada", "aac3f4", "c010cb", "a2b698", "a2d6a9", "a30d04", "c029dd", "a26b51", "a2b2e1", "a68d6f", "a1e241", "a2d2f2", "a17bfe", "c05ea2"], lastSeen: 1744504181.8), Swift_ADS_B_Statistics.AircraftType(name: "A321-271NX", icao: "A321", aircraft: ["a6c70f", "c05eb6", "ad27f3", "c0193b", "a69463", "c0192e", "a6ce7d", "a7de16", "adcd6d", "a7fe27", "ad9ac9", "a6bfa6", "a99e09", "acb9ed", "adc238", "acaec8", "c051cc", "a6aaba", "a0dae2", "a6cacb", "ac72e4", "a69f88", "a6b470", "a69bcd", "ad3581", "a6d83c", "a6e720", "ac96be", "c010ea", "a1d2dc", "a04641", "a6f5fc", "c051d1", "a402dd", "49530b", "ace96c", "a6bbef", "c010f6", "a1cf6b", "a0c075", "a49206", "c03493", "4cc56d", "a67452", "a791c0", "a6981a", "acb285", "a97c9a", "ad1cde", "c010ec", "adbaca", "c051d0", "ad7701", "c0196c", "a6f9b3", "a014c9", "a6dbf3", "adbe91", "c058b4", "a08663", "add376", "a6d234", "a6c358", "a6eacf", "ad6bdc", "a8e0a5", "a178de", "a03765", "c05ea6", "a84d25", "a6a33f", "ad5329", "a07522", "a07579", "a98408", "c05bcb", "ada5ee", "a6ffc3", "a1cf48", "adb723", "a037b9", "c005c5", "c07721", "c05eac", "addadb", "a6e361", "c051da", "ad60b7", "a987bf", "a6b833", "adde95", "c05bd5", "3f97fd", "ad1927", "adb35c", "c051c6", "ad7ab8"], lastSeen: 1744488319.7)
        ]
        
        #expect(frequentTypes == expectedFrequentTypes)
    }
}
