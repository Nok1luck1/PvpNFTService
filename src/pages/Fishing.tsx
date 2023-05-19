import React, { useState } from "react";
import MyNavbar from "../components/MyNavbar";
import styled from "styled-components";
import { getContract } from "../components/PETR";

interface LakeProps {
  width?: number;
  height?: number;
}

const LAKE_WIDTH = 900;
const LAKE_HEIGHT = 600;

export default function FishingEl() {
  const [isAnimationPlaying, setIsAnimationPlaying] = useState(false);
  const [errorMsg, setErrorMsg] = useState<null | string>(null);

  const handleClick = async () => {
    try {
      const { contract } = getContract();
      const tx = await contract.approve(
        "0x86a87F771Df8A0425d0Bfe4dBEc4c381857C0545",
        1
      );
      tx.wait();
      if (tx) {
        setIsAnimationPlaying(!isAnimationPlaying);
      }
    } catch (err) {
      if (err) setErrorMsg((err as Error).message);
      setTimeout(() => {
        setErrorMsg("");
      }, 9000);
    }
  };

  return (
    <>
      <MyNavbar />
      FISHING PAGE
      {errorMsg && <p className="error">Error: {errorMsg}</p>}
      <main className="main">
        <Fishing>
          <Lake width={LAKE_WIDTH} height={LAKE_HEIGHT}>
            <button className="btn" onClick={handleClick}>
              {isAnimationPlaying ? "pause" : "start"}
            </button>
            <svg
              className="bridge"
              width="267"
              height="182"
              viewBox="0 0 267 182"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M3 22H177.234C177.679 22 178.111 22.1484 178.463 22.4217L264 89M3 22L3 114.479C3 115.584 3.89543 116.479 5 116.479H12.5866C13.6912 116.479 14.5866 115.584 14.5866 114.479V34M3 22L14.5866 34M82 89L14.5866 34M82 89V177C82 178.105 82.8954 179 84 179H95C96.1046 179 97 178.105 97 177V89M82 89H97M264 89H250M264 89V177C264 178.105 263.105 179 262 179H252C250.895 179 250 178.105 250 177V89M97 89H250"
                stroke="black"
                stroke-width="5"
              />
              <path
                d="M103.5 33.196L120.686 51.9092C123.46 54.9305 128.5 52.9674 128.5 48.8654V5V2.5H126H81H78.5V5V48.8654C78.5 52.9674 83.5398 54.9305 86.3144 51.9092L103.5 33.196Z"
                fill="black"
                stroke="black"
                stroke-width="5"
              />
            </svg>
            {isAnimationPlaying ? (
              <svg
                className="hero-animate"
                width="376"
                height="495"
                viewBox="0 0 376 495"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M94 343.541L66 422.541H13L3 494M94 343.541L68 316.041L78 271.541M94 343.541L54 328.541L60 293.541"
                  stroke="black"
                  stroke-width="5"
                />
                <circle cx="100" cy="331.541" r="12" fill="#020000" />
                <path
                  d="M345.811 74.9094L364.734 95.1419L375.266 68.2644L347.635 70.2541L345.811 74.9094ZM267.568 43.0325L269.488 44.6336L267.568 43.0325ZM269.834 42.4513L270.746 40.1236L269.834 42.4513ZM38.9202 321.141L269.488 44.6336L265.648 41.4315L35.0801 317.939L38.9202 321.141ZM268.922 44.7789L348.139 75.8216L349.963 71.1662L270.746 40.1236L268.922 44.7789ZM269.488 44.6336C269.351 44.7989 269.122 44.8575 268.922 44.7789L270.746 40.1236C268.943 39.4168 266.889 39.9437 265.648 41.4315L269.488 44.6336Z"
                  fill="black"
                />
                <circle
                  cx="61.4534"
                  cy="278.905"
                  r="7.5"
                  transform="rotate(110 61.4534 278.905)"
                  fill="black"
                />
              </svg>
            ) : (
              <svg
                className="hero"
                width="362"
                height="212"
                viewBox="0 0 362 212"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  id="sitting-man"
                  d="M296.15 211L302.236 147.117C302.334 146.091 303.196 145.307 304.227 145.307H347C348.105 145.307 349 144.411 349 143.307V70M349 70L290 97.8571M349 70L314.205 106.712"
                  stroke="black"
                  stroke-width="5"
                />
                <ellipse
                  cx="348.813"
                  cy="55.8429"
                  rx="13.1869"
                  ry="13.8429"
                  fill="black"
                />
                <path
                  d="M15 63.5L0.566243 88.5H29.4338L15 63.5ZM336.838 113.807L18.5079 0.594174L16.8325 5.30511L335.162 118.518L336.838 113.807ZM12.5 4.83402V85H17.5V4.83402H12.5ZM18.5079 0.594174C15.5783 -0.447732 12.5 1.72464 12.5 4.83402H17.5C17.5 5.17951 17.158 5.42088 16.8325 5.30511L18.5079 0.594174Z"
                  fill="black"
                />
                <circle cx="308.5" cy="115.5" r="7.5" fill="black" />
              </svg>
            )}
          </Lake>
        </Fishing>
      </main>
    </>
  );
}

const Fishing = styled.div`
  position: relative;
  max-width: 1000px;
  height: 500px;
  margin: 0 auto;
  margin-top: 200px;
  padding: 0 25px;
  display: flex;
  align-items: center;
`;

const Lake = styled.div<LakeProps>`
  position: relative;
  width: ${(props) => props.width}px;
  height: ${(props) => props.height}px;
  background: linear-gradient(
    to bottom,
    rgb(72, 106, 255) 65%,
    rgb(23, 77, 255) 35%
  );
`;
