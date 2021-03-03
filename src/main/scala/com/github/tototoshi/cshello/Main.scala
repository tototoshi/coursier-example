package com.github.tototoshi.cshello

import org.slf4j.LoggerFactory

import scala.io.Source
import scala.util.Using

object Main {

  private val logger = LoggerFactory.getLogger(getClass)

  def main(args: Array[String]): Unit = {
    val headCommit = Using.resource(getClass.getResourceAsStream("/head.txt")) { in =>
      Using.resource(Source.fromInputStream(in)) { src =>
        src.mkString
      }
    }

    logger.info(s"Version: $headCommit")
  }

}
