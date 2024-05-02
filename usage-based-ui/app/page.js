"use client";

import axios from "axios";
import Button from "@leafygreen-ui/button";
import styles from "./page.module.css";
import * as Realm from "realm-web";
import ChartsEmbedSDK from "@mongodb-js/charts-embed-dom";
import React, { useEffect, useRef, useState } from "react";

export default function Home() {
  const sdk = new ChartsEmbedSDK({
    baseUrl: "https://charts.mongodb.com/charts-jeffn-zsdtj",
  });
  const dashboardDiv = useRef(null);
  const [rendered, setRendered] = useState(false);
  const [dashboard] = useState(
    sdk.createDashboard({
      dashboardId: "63d1171f-fd08-49d0-800a-f0158c317bc5",
      widthMode: "scale",
      heightMode: "scale",
      background: "#fff",
    })
  );

  useEffect(() => {
    dashboard
      .render(dashboardDiv.current)
      .then(() => setRendered(true))
      .catch((err) => console.log("Error during Charts rendering.", err));

    if (dashboardDiv.current) {
      dashboardDiv.current.style.height = "100%";
    }

    const interval = setInterval(() => {
      if (dashboard) {
        dashboard.refresh();
        console.log("Dashboard refreshed");
      }
    }, 5000);

    return () => clearInterval(interval);
  }, [dashboard]);

  const handleResetClick = async () => {
    try {
      const response = await axios.get(
        "https://eu-west-2.aws.data.mongodb-api.com/app/mlocustdemo-bctgv/endpoint/reset"
      );
      console.log("Reset successful", response.data);
    } catch (error) {
      console.error("Reset failed", error);
    }
  };

  const handleDataClick = async () => {
    try {
      const apiURL = "localhost";
      const response = await axios.get(`http://${apiURL}:8911/data`);
      console.log("Data Added successfully", response.data);
    } catch (error) {
      console.error("Data failed to be added", error);
    }
  };

  return (
    <div>
      <div>
        <div className={styles.buttonContainer}>
          <Button
            darkMode={false}
            disabled={false}
            size="large"
            onClick={() => handleDataClick()}
          >
            Start Demo
          </Button>
          <Button
            darkMode={false}
            disabled={false}
            size="large"
            onClick={() => handleResetClick()}
          >
            Reset
          </Button>
        </div>
        <div className={styles.mainContainer}>
          <div className={styles.iframeWrapper}>
            <div ref={dashboardDiv} />
          </div>
        </div>
      </div>
    </div>
  );
}
