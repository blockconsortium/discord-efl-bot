name := """discord-tip-bot"""
organization := "nl.egulden"

version := "1.0-SNAPSHOT"

lazy val root = (project in file("."))
  .enablePlugins(PlayScala)
  .disablePlugins(PlayLayoutPlugin)

scalaVersion := "2.13.0"

libraryDependencies ++= Seq(
  guice,

  // Database
  "mysql"             %  "mysql-connector-java"  % "5.1.41",
  "com.typesafe.play" %% "play-slick"            % "4.0.2",
  "com.typesafe.play" %% "play-slick-evolutions" % "4.0.2",

  // Discord
  "net.dv8tion" % "JDA" % "4.0.0_46",

  // Test dependencies
  "org.scalatestplus.play" %% "scalatestplus-play" % "4.0.3" % Test,
  "org.scalamock"          %% "scalamock"          % "4.4.0" % Test
)

resolvers += Resolver.JCenterRepository

// Adds additional packages into Twirl
//TwirlKeys.templateImports += "nl.egulden.controllers._"

// Adds additional packages into conf/routes
// play.sbt.routes.RoutesKeys.routesImport += "nl.egulden.binders._"
