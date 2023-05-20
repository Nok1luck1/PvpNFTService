import React from "react";
import MyNavbar from "../components/MyNavbar";
// @ts-ignore
import video from "../videos/chill.mp4";

export default function Store() {
  return (
    <>
      <MyNavbar />
      <div className="store">
        STORE PAGE
        <video width="320" height="240" controls>
          <source src={video} type="video/mp4" />
        </video>
      </div>
    </>
  );
}
