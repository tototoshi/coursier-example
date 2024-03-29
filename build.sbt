import sbt._

import java.nio.charset.StandardCharsets

val scalaVersion_2_13 = "2.13.8"

lazy val root = project
  .in(file("."))
  .enablePlugins(GitPlugin)
  .settings(
    name := "cshello",
    organization := "com.github.tototoshi",
    version := "0.1.0-SNAPSHOT",
    scalaVersion := scalaVersion_2_13,
    libraryDependencies ++= Seq(
      "org.slf4j" % "slf4j-api" % "1.7.36",
      "ch.qos.logback" % "logback-classic" % "1.2.11"
    ),
    Compile / resourceGenerators += Def.task {
      val file = (Compile / resourceManaged).value / "head.txt"
      IO.write(file, git.gitHeadCommit.value.map(_.getBytes(StandardCharsets.UTF_8)).getOrElse(Array.empty))
      Seq(file)
    }.taskValue
  )
