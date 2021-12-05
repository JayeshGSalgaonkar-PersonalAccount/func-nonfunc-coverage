package ntuc_memberportal

import scala.language.postfixOps
import io.gatling.core.Predef._
import com.intuit.karate.gatling.PreDef._
import io.gatling.core.structure.{PopulationBuilder, ScenarioBuilder}
import org.apache.maven.wagon.PathUtils

import scala.concurrent.duration._

class EnduranceSimulation extends Simulation{

  val user_Service: ScenarioBuilder = scenario("user-service").exec(karateFeature("classpath:ntuc_memberportal/FeatureFiles/user-service/performance.feature"))

  setUp(
    user_Service.inject(constantUsersPerSec(50) during (30 seconds))
  )

}