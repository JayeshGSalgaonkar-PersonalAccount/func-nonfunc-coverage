package memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_Total extends Simulation {

  val user_Service: ScenarioBuilder = scenario("user-service").exec(karateFeature("classpath:memberportal/FeatureFiles/user-service/performance.feature"))
  val member_Service: ScenarioBuilder = scenario("member-service").exec(karateFeature("classpath:memberportal/FeatureFiles/member-service/performance.feature"))
  val deal_Service: ScenarioBuilder = scenario("deal-service").exec(karateFeature("classpath:memberportal/FeatureFiles/deal-service/performance.feature"))
  val notification_Service: ScenarioBuilder = scenario("notification-service").exec(karateFeature("classpath:memberportal/FeatureFiles/notification-service/performance.feature"))
  val payment_Service: ScenarioBuilder = scenario("payment-service").exec(karateFeature("classpath:memberportal/FeatureFiles/payment-service/performance.feature"))
//  val protection_Service: ScenarioBuilder = scenario("protection-service").exec(karateFeature("classpath:memberportal.FeatureFiles.protection-service/case.feature"))



  setUp(
    user_Service.inject(constantConcurrentUsers(2000).during(1500)),
    member_Service.inject(constantConcurrentUsers(2000).during(1500)),
    deal_Service.inject(constantConcurrentUsers(2000).during(1500)),
    notification_Service.inject(constantConcurrentUsers(2000).during(1500)),
    payment_Service.inject(constantConcurrentUsers(2000).during(1500))
//    protection_Service.inject(constantConcurrentUsers(8000).during(1500))
  )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))