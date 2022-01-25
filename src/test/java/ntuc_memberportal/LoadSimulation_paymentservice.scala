package ntuc_memberportal

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import io.gatling.core.structure.ScenarioBuilder

import scala.language.postfixOps

class LoadSimulation_paymentservice extends Simulation {

  val payment_Service: ScenarioBuilder = scenario("payment-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/payment-service/performance.feature"))

  setUp(
    payment_Service.inject(constantConcurrentUsers(400).during(480))
    )
}

//  .inject(constantUsersPerSec(100) during(10))
//  .inject(rampUsers(100).during(10 seconds))