import React, { useEffect, useState } from "react";
import MyNavbar from "../components/MyNavbar";

export default function MyEquipment(props: any) {
  const section = document.querySelector(".section");

  section?.addEventListener("click", () => {
    section.classList.toggle("clicked");
  });

  return (
    <>
      <MyNavbar />
      MY EQUIPMENT PAGE
      <div className="box">
        <div className="section">
          <h1 className="name">Default</h1>
          <svg
            className="rod"
            width="337"
            height="123"
            viewBox="0 0 337 123"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M15 63.5L0.566243 88.5H29.4338L15 63.5ZM336.838 113.807L18.5079 0.594174L16.8325 5.30511L335.162 118.518L336.838 113.807ZM12.5 4.83402V85H17.5V4.83402H12.5ZM18.5079 0.594174C15.5783 -0.447732 12.5 1.72464 12.5 4.83402H17.5C17.5 5.17951 17.158 5.42088 16.8325 5.30511L18.5079 0.594174Z"
              fill="black"
            />
            <circle cx="308.5" cy="115.5" r="7.5" fill="black" />
          </svg>
        </div>
        <div className="section">
          <h1 className="name">{props.name}</h1>
        </div>
        <div className="section">
          <h1 className="name">{props.name}</h1>
        </div>
        <div className="section">
          <h1 className="name">{props.name}</h1>
        </div>
        <div className="section">
          <h1 className="name">{props.name}</h1>
        </div>
        <div className="section">
          <h1 className="name">{props.name}</h1>
        </div>
      </div>
    </>
  );
}
