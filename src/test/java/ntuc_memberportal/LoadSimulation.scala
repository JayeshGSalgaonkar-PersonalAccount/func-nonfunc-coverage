package ntuc_memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation extends Simulation {

  val user_Service: ScenarioBuilder = scenario("user-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/user-service/performance.feature"))
  val member_Service: ScenarioBuilder = scenario("member-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/member-service/performance.feature"))
  val deal_Service: ScenarioBuilder = scenario("deal-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/deal-service/performance.feature"))
  val notification_Service: ScenarioBuilder = scenario("notification-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/notification-service/performance.feature"))
  val payment_Service: ScenarioBuilder = scenario("payment-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/payment-service/performance.feature"))

  setUp(
    user_Service.inject(constantConcurrentUsers(400).during(480)),
    member_Service.inject(constantConcurrentUsers(400).during(480)),
    deal_Service.inject(constantConcurrentUsers(400).during(480)),
    notification_Service.inject(constantConcurrentUsers(400).during(480)),
    payment_Service.inject(constantConcurrentUsers(400).during(480))
    );
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))