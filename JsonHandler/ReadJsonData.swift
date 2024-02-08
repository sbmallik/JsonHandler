import SwiftUI

struct Metadata: Codable {
  let application: String?
  let environment: String?
  let platform: String?
  let synthetic: String?
  let team: String?
  let author: String?
  let siteCode: String?
  // let tags: [String?]
  // let timestamp: String?
  
  init(application: String? = "nativeAds", environment: String? = "production", platform: String? = "ios", synthetic: String?, team: String? = "nativeApps", author: String? = "qe", siteCode: String?) {
    self.application = application
    self.environment = environment
    self.platform = platform
    self.synthetic = synthetic
    self.team = team
    self.author = author
    self.siteCode = siteCode
  }
}

struct jsonDataModel: Codable {
  struct Data: Codable {
    let MVPlacementKey: String?
    let PackageName: String?
    let adCount: String?
    let aic: String?
    let build: String?
    let clientId: String?
    let contentid: String?
    let cst_section: String?
    let cst_subsection: String?
    let devicetype: String?
    let front: String?
    let features: String?
    let idFlag: String?
    let nightmode: String?
    let pageType: String?
    let position: String?
    let ss: String?
    let ssts_section: String?
    let ssts_subsection: String?
    let title: String?
    let topic: String?
    let userguid: String?
    let variant: String?
    let ver: String?
  }
  var metadata: Metadata?
  let data: [Data]
}

class ReadJsonDataViewModel: ObservableObject {
  @Published var jsonData: jsonDataModel? = nil
  
  init() {
    getData()
    jsonData?.metadata = Metadata(synthetic: "phone", siteCode: "USAT")
  }
  
  func getData() {
    guard let data = getJSONData() else { return }
    do {
      jsonData = try JSONDecoder().decode(jsonDataModel.self, from: data)
    } catch let error {
      print("Error decoding: \(error)")
    }
  }
  
  func getJSONData() -> Data? {
    guard let sourcesUrl = Bundle.main.url(forResource: "workflowData", withExtension: "json") else {
      fatalError("Could'nt locate the source file.")
    }
    guard let analyticsData = try? Data(contentsOf: sourcesUrl) else {
      fatalError("Could'nt convert analytics data.")
    }
    return analyticsData
  }
}

struct ReadJsonData: View {
  
  @StateObject var vm = ReadJsonDataViewModel()
  
  var body: some View {
    List {
      VStack(spacing: 20) {
        if let jsonData = vm.jsonData?.data[1],
           let metadata = vm.jsonData?.metadata {
          Text(metadata.application ?? "")
          Text(metadata.siteCode ?? "")
          Text(metadata.platform ?? "")
          // Text(jsonData.MVPlacementKey ?? "")
          Text(jsonData.PackageName ?? "")
          Text(jsonData.adCount ?? "")
          // Text(jsonData.aic ?? "")
          Text(jsonData.build ?? "")
          // Text(jsonData.clientId ?? "")
          Text(jsonData.contentid ?? "")
          // Text(jsonData.cst_section ?? "")
          // Text(jsonData.cst_subsection ?? "")
          Text(jsonData.devicetype ?? "")
          // Text(jsonData.features ?? "")
          Text(jsonData.front ?? "")
          // Text(jsonData.idFlag ?? "")
          // Text(jsonData.nightmode ?? "")
          Text(jsonData.pageType ?? "")
          Text(jsonData.position ?? "")
          // Text(jsonData.ss ?? "")
          Text(jsonData.ssts_section ?? "")
          Text(jsonData.ssts_subsection ?? "")
          Text(jsonData.title ?? "")
          // Text(jsonData.topic ?? "")
          // Text(jsonData.userguid ?? "")
          // Text(jsonData.variant ?? "")
          Text(jsonData.ver ?? "")
        }
      }
    }
  }
}

#Preview {
  ReadJsonData()
}
