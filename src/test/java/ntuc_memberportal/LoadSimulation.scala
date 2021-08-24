package ntuc_memberportal

import scala.language.postfixOps
import io.gatling.core.Predef._
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.structure.ScenarioBuilder
import scala.concurrent.duration._


class LoadSimulation extends Simulation {

  val member_Service_LinkPoints: ScenarioBuilder = scenario("member-service linkpoints").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/member-service/member-serviceLinkPoints.feature"))
  val user_Service_UserPreference: ScenarioBuilder = scenario("user-service userpreference").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/user-service/user-servicePreference.feature"))

  setUp(
    member_Service_LinkPoints.inject(constantUsersPerSec(1) during(10)),
    user_Service_UserPreference.inject(constantUsersPerSec(1) during(10))
  )
}



//  .inject(constantUsersPerSec(1) during(10))
//  .inject(rampUsers(10).during(10 seconds))