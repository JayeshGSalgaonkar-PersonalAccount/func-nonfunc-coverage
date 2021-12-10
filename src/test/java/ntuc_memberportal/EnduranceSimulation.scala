package ntuc_memberportal

import scala.language.postfixOps
import io.gatling.core.Predef._
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.structure.{PopulationBuilder, ScenarioBuilder}
import org.apache.maven.wagon.PathUtils

import scala.concurrent.duration._

class EnduranceSimulation extends Simulation {

  val user_Service: ScenarioBuilder = scenario("user-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/user-service/performance.feature"))
  val member_Service: ScenarioBuilder = scenario("member-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/member-service/performance.feature"))

  setUp(
    user_Service.inject(rampUsers(500) during (300 seconds)),
    user_Service.inject(constantUsersPerSec(10) during (300 seconds)),
    member_Service.inject(rampUsers(500) during (300 seconds)),
    member_Service.inject(constantUsersPerSec(10) during (300 seconds))
  )

}