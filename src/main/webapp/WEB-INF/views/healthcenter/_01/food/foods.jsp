<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="viewport-fit=cover, width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/images/favicon.ico" />
<script src="https://use.fontawesome.com/releases/v5.15.3/js/all.js"
	crossorigin="anonymous"></script>
<!-- Font Awesome icons (free version) 要改根目錄-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/styles1.css"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->

<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://web-assets.myfitnesspal.com/fonts/neue-plak-ua.css"
	crossorigin="true" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap"
	rel="stylesheet">
<style type="text/css" id="jss-server-side">
html {
	box-sizing: border-box;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

*, *::before, *::after {
	box-sizing: inherit;
}

strong, b {
	font-weight: 700;
}

@media print {
	body {
		background-color: #fff;
	}
}

body::backdrop {
	background-color: #F0F2F4;
}

.MuiTypography-root {
	margin: 0;
}

.MuiTypography-body2 {
	font-size: 0.875rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 400;
	line-height: 1.5;
}

.MuiTypography-body1 {
	font-size: 1rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 400;
	line-height: 1.5;
}

.MuiTypography-caption {
	font-size: 0.75rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 400;
	line-height: 1.66;
}

.MuiTypography-button {
	font-size: 0.875rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 500;
	line-height: 1.75;
	text-transform: uppercase;
}

.MuiTypography-h1 {
	font-size: 1.5625rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 900;
	line-height: 1.12;
}

.MuiTypography-h2 {
	font-size: 1.25rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 800;
	line-height: 1.15;
}

@media ( min-width :576px) {
	.MuiTypography-h2 {
		font-size: 1.3043rem;
	}
}

@media ( min-width :992px) {
	.MuiTypography-h2 {
		font-size: 1.5217rem;
	}
}

@media ( min-width :1200px) {
	.MuiTypography-h2 {
		font-size: 1.5217rem;
	}
}

.MuiTypography-h3 {
	font-size: 1.125rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 700;
	line-height: 1.2;
}

@media ( min-width :576px) {
	.MuiTypography-h3 {
		font-size: 1.25rem;
	}
}

@media ( min-width :992px) {
	.MuiTypography-h3 {
		font-size: 1.25rem;
	}
}

@media ( min-width :1200px) {
	.MuiTypography-h3 {
		font-size: 1.25rem;
	}
}

.MuiTypography-h4 {
	font-size: 16px;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 600;
	line-height: 1.25;
}

.MuiTypography-h5 {
	font-size: 0.875rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 600;
	line-height: 1.334;
}

.MuiTypography-h6 {
	font-size: 0.75rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 600;
	line-height: 1.6;
}

.MuiTypography-subtitle1 {
	font-size: 1rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 400;
	line-height: 1.75;
}

.MuiTypography-subtitle2 {
	font-size: 0.875rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 500;
	line-height: 1.57;
}

.MuiTypography-overline {
	font-size: 0.75rem;
	font-family: "Neue Plak UA", Helvetica, Arial, -apple-system, sans-serif;
	font-weight: 400;
	line-height: 2.66;
	text-transform: uppercase;
}

.MuiTypography-srOnly {
	width: 1px;
	height: 1px;
	overflow: hidden;
	position: absolute;
}

.MuiTypography-alignLeft {
	text-align: left;
}

.MuiTypography-alignCenter {
	text-align: center;
}

.MuiTypography-alignRight {
	text-align: right;
}

.MuiTypography-alignJustify {
	text-align: justify;
}

.MuiTypography-noWrap {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.MuiTypography-gutterBottom {
	margin-bottom: 0.35em;
}

.MuiTypography-paragraph {
	margin-bottom: 16px;
}

.MuiTypography-colorInherit {
	color: inherit;
}

.MuiTypography-colorPrimary {
	color: #0066EE;
}

.MuiTypography-colorSecondary {
	color: #FAFAFA;
}

.MuiTypography-colorTextPrimary {
	color: #222628;
}

.MuiTypography-colorTextSecondary {
	color: #6D717A;
}

.MuiTypography-colorError {
	color: #F22613;
}

.MuiTypography-displayInline {
	display: inline;
}

.MuiTypography-displayBlock {
	display: block;
}

.jss17 {
	width: 100%;
	height: 50px;
	margin: 0;
	padding: 10px 16px;
	z-index: 9999;
	border-bottom: 1px solid #0065a7;
	background-color: #0070bf;
}

.jss18 {
	display: inline-block;
	margin-top: 4px;
	vertical-align: middle;
}

.jss18 img {
	height: 26px;
}

.jss19 {
	color: #fff;
	cursor: pointer;
	display: inline-block;
	margin-right: 19px;
}

.jss20 {
	color: #fff;
	width: 100%;
	font-size: 13px;
	list-style: none;
	font-weight: bold;
	text-transform: uppercase;
	background-color: #000;
}

.jss20 a {
	color: inherit;
	text-decoration: none;
}

.jss21 {
	width: 110%;
}

.jss22 {
	display: block;
}

.jss23 {
	border-bottom: 1px solid #0064a5;
	background-color: #0070bf;
}

.jss24 {
	border-bottom: 1px solid #00497a;
	background-color: #00548b;
}

.jss25 {
	padding: 14px;
	border-bottom: 1px solid #0064a5;
	background-color: #0070bf;
}

.jss25 a {
	display: block;
}

.jss26 {
	padding: 14px;
	border-bottom: 1px solid #00497a;
	background-color: #00548b;
}

.jss26 a {
	display: block;
}

.jss27 {
	border-bottom: 1px solid #0064a5;
	background-color: #0070bf;
}

.jss27 div {
	padding-top: 14px;
	border-bottom: 1px solid #00497a;
	padding-bottom: 14px;
}

.jss27 a {
	padding-left: 29px;
}

.jss28 {
	border-bottom: 1px solid #00497a;
	background-color: #00548b;
}

.jss28 div {
	padding-top: 14px;
	border-bottom: 1px solid #00497a;
	padding-bottom: 14px;
}

.jss28 a {
	padding-left: 29px;
}

.jss29 {
	margin-top: -10px;
}

.jss30 {
	top: 0;
	width: 100%;
	position: fixed;
}

.jss31 {
	margin-top: 50px;
}

.jss32 {
	padding: 10px 14px;
	border-bottom: 1px solid #0064a5;
	background-color: #0070bf;
}

.jss32 svg path {
	fill: #fff;
}

.jss32 svg polygon {
	fill: #fff;
}

@media screen and (min-width: 768px) {
	.jss33 {
		text-align: left;
		padding-top: 25px;
		background-color: #FFFFFF;
	}
	.jss34 {
		clear: both;
		width: 980px;
		margin: 0 auto;
		position: relative;
	}
	.jss18 img {
		width: 229px;
		height: 30px;
	}
	.jss35 {
		display: flex;
		padding-bottom: 20px;
		justify-content: space-between;
	}
	.jss36 {
		color: #FFF;
		display: inline-block;
		padding: 0px 18px;
		font-weight: bold;
		line-height: 45px;
		text-decoration: none;
	}
	.jss37 {
		display: inline-block;
	}
	.jss38 {
		background-color: #0a5282;
	}
	.jss39 {
		font-size: 13px;
		font-weight: bold;
		line-height: 45px;
		text-transform: uppercase;
		background-color: #0070BF;
	}
	.jss39>.jss34>a:hover {
		background-color: #0a5282;
	}
	.jss27 {
		font-size: 13px;
		line-height: 45px;
		background-color: #0a5282;
	}
	.jss27 .jss36 {
		font-weight: normal;
	}
	.jss27 .jss38 {
		font-weight: bold;
	}
	.jss40 {
		left: 0;
		right: 3px;
		z-index: 10;
		position: absolute;
	}
	.jss41 {
		background-position: 0 -70px;
		;
	}
	.jss42 {
		background-position: 0 -25px;
		;
	}
	.jss43 {
		background-position: 0 -50px;
		;
	}
	.jss44 {
		background-position: 0 -5px;
		;
	}
	.jss45 a {
		display: inline-block;
		padding: 0 0 0 25px;
		background-image:
			url(/react-static/8267d44a81bddaa6fe2efd70568f95ce.png);
		background-repeat: no-repeat;
	}
	.jss46 a {
		font-weight: 800;
	}
	.jss47>div {
		display: inline-block;
		padding: 0 10px;
		border-right: 1px solid #e6e6e6;
	}
	.jss47 a {
		color: #0072BC;
		line-height: 16px;
		margin-right: 10px;
		text-decoration: none;
	}
	.jss47 a:hover {
		color: #f7941e;
	}
	.jss47 a:last-of-type {
		margin-right: 0;
	}
	.jss47>div:last-of-type {
		border-right: 0;
	}
	.jss48 {
		font-size: 12px;
		line-height: 1.5em;
		margin-left: auto;
	}
	.jss48>div {
		display: inline-block;
		padding: 0 10px;
		border-right: 1px solid #e6e6e6;
	}
	.jss48 a {
		color: #0072BC;
		line-height: 16px;
		margin-right: 10px;
		text-decoration: none;
	}
	.jss48 a:hover {
		color: #f7941e;
	}
	.jss48 a:last-of-type {
		margin-right: 0;
	}
	.jss48>div:last-of-type {
		border-right: 0;
	}
	.jss49 {
		font-size: 14;
		font-weight: bold;
	}
	.jss49>div {
		display: inline-block;
		padding: 0 10px;
		border-right: 1px solid #e6e6e6;
	}
	.jss49 a {
		color: #0072BC;
		line-height: 16px;
		margin-right: 10px;
		text-decoration: none;
	}
	.jss49 a:hover {
		color: #f7941e;
	}
	.jss49 a:last-of-type {
		margin-right: 0;
	}
	.jss49>div:last-of-type {
		border-right: 0;
	}
	.jss50 a {
		color: #fff;
		width: 24px;
		padding: 4px 5px;
		margin-left: 5px;
		margin-right: 4px;
		border-radius: 24px;
		background-color: #0072BC;
	}
	.jss50 a:hover {
		color: #fff;
		background-color: #f7941e;
	}
	.jss51 {
		font-weight: bold;
	}
}

.jss88 {
	margin-bottom: 1rem;
}

@media only screen and (min-width: 1024px) {
	.jss88 {
		right: 30px;
		position: absolute;
	}
}

.jss80 {
	width: 100%;
	background: #efefef;
	text-align: center;
}

.jss81 {
	width: 940px;
	height: 120px;
	margin: auto;
	font-size: 12px;
	text-align: center;
	padding-top: 32px;
}

.jss82 {
	margin: 0 0 1em;
	display: inline-block;
	padding: 0;
	max-width: 65%;
	list-style: none;
	text-align: center;
	line-height: 1.92;
}

.jss82 li {
	margin: 0 5px;
	display: inline-block;
}

.jss82 a {
	color: #0072bc;
	font-size: 12px;
	text-decoration: none;
}

.jss82 a:hover {
	color: #f7941e;
}

.jss83 {
	font-size: 12px;
}

.jss84 {
	color: #757575;
	width: 100%;
	padding: 24px 0;
	font-size: 14px;
	background: #efefef;
	text-align: center;
}

.jss84 p {
	margin: 20px 0 10px;
}

.jss84 img {
	margin-bottom: 24px;
}

.jss84 hr {
	margin: 7px 16px 10px;
	border-top: 1px solid #eee;
	border-color: #e0e0e0;
	border-width: 2px;
}

.jss85 {
	bottom: 0;
	position: fixed;
}

@media only screen and (max-width: 320px) and (orientation: landscape) {
	.jss85 {
		position: relative;
	}
}

@media only screen and (max-width: 320px) and (orientation: portrait) {
	.jss85 {
		position: fixed;
	}
}

.jss86 {
	margin: 1em 0;
	list-style: none;
	line-height: 1.92;
	margin-left: -5px;
	padding-left: 0;
	padding-right: 0;
}

.jss86 li {
	display: inline-block;
}

.jss86 li:not(:first-child):before {
	content: "•";
	padding-left: 5px;
}

.jss86 li div {
	display: inline-block;
}

.jss86 li a {
	color: inherit;
	padding: 0 6px;
	text-decoration: none;
}

.jss87 {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
}

.MuiSnackbar-root {
	left: 8px;
	right: 8px;
	display: flex;
	z-index: 1400;
	position: fixed;
	align-items: center;
	justify-content: center;
}

.MuiSnackbar-anchorOriginTopCenter {
	top: 8px;
}

@media ( min-width :576px) {
	.MuiSnackbar-anchorOriginTopCenter {
		top: 24px;
		left: 50%;
		right: auto;
		transform: translateX(-50%);
	}
}

.MuiSnackbar-anchorOriginBottomCenter {
	bottom: 8px;
}

@media ( min-width :576px) {
	.MuiSnackbar-anchorOriginBottomCenter {
		left: 50%;
		right: auto;
		bottom: 24px;
		transform: translateX(-50%);
	}
}

.MuiSnackbar-anchorOriginTopRight {
	top: 8px;
	justify-content: flex-end;
}

@media ( min-width :576px) {
	.MuiSnackbar-anchorOriginTopRight {
		top: 24px;
		left: auto;
		right: 24px;
	}
}

.MuiSnackbar-anchorOriginBottomRight {
	bottom: 8px;
	justify-content: flex-end;
}

@media ( min-width :576px) {
	.MuiSnackbar-anchorOriginBottomRight {
		left: auto;
		right: 24px;
		bottom: 24px;
	}
}

.MuiSnackbar-anchorOriginTopLeft {
	top: 8px;
	justify-content: flex-start;
}

@media ( min-width :576px) {
	.MuiSnackbar-anchorOriginTopLeft {
		top: 24px;
		left: 24px;
		right: auto;
	}
}

.MuiSnackbar-anchorOriginBottomLeft {
	bottom: 8px;
	justify-content: flex-start;
}

@media ( min-width :576px) {
	.MuiSnackbar-anchorOriginBottomLeft {
		left: 24px;
		right: auto;
		bottom: 24px;
	}
}

.jss52 {
	color: #F22613;
	flex-wrap: nowrap;
	box-shadow: 0 12px 27px 0 rgba(0, 0, 0, 0.05);
	margin-top: 96px;
	font-weight: 600;
	border-color: #F22613;
	border-radius: 4px;
	background-color: #fdefef;
}

.jss53 {
	margin-right: 2px;
}

@media ( max-width :1199.95px) {
	.jss53 {
		padding-left: 0;
	}
}

@media ( max-width :991.95px) {
	.jss52 {
		margin-top: 64px;
	}
}

.jss14 {
	position: relative;
	min-height: 500px;
}

.jss15 {
	margin: 0 auto;
	padding: 32px 0;
}

@media ( max-width :1199.95px) {
	.jss15 {
		padding: 24px 16px;
	}
}

.jss16 {
	color: #fff;
	font-weight: 400;
	text-decoration: underline;
}

.jss16:hover {
	cursor: pointer;
}

.jss56 {
	width: 100%;
}

.jss56 form {
	display: flex;
	box-shadow: 0 0 9px 0 rgba(0, 0, 0, 0.2);
	border-radius: 43px;
	background-color: white;
}

.jss56 button {
	width: 2.188em;
	border: none;
	height: 2.5625em;
	padding: 0;
	overflow: hidden;
	border-radius: 0px 43px 43px 0px;
	background-color: white;
}

.jss56 img {
	width: 1.25em;
	height: 1.25em;
	display: block;
}

.jss56 ::-webkit-input-placeholder {
	color: #DDD;
}

.jss56 :-ms-input-placeholder {
	color: #DDD;
}

.jss56 button:hover {
	cursor: pointer;
}

.jss57::-webkit-search-cancel-button {
	right: 16px;
	position: relative;
}

.jss57::-ms-clear {
	margin-right: 16px;
}

.jss58 {
	width: 100%;
	border: none;
	height: 3.4em;
	outline: none;
	font-size: .75rem;
	padding-left: 1.5em;
	border-radius: 43px 0px 0px 43px;
}

.jss58 ::-ms-clear {
	display: none;
}

@media only screen and (min-width: 768px) {
	.jss56 button {
		width: 5em;
		height: 5em;
	}
	.jss56 img {
		width: 3em;
		height: 3em;
	}
	.jss58 {
		color: #212121;
		height: 4em;
		font-size: 1.25rem;
		padding-left: 2em;
	}
	.jss59 {
		top: 20%;
		width: 2.5em;
		height: 5em;
	}
}

.jss78 {
	text-align: center;
	margin-bottom: 1em;
}

.jss78>h2 {
	font-size: 1.5rem;
	font-weight: 700;
	line-height: 1.33;
}

.jss79 {
	margin: 0 auto;
	max-width: content-max-width-sm;
}

@media ( min-width :576px) {
	.jss78 {
		text-align: left;
	}
	.jss79 {
		margin: 0;
		max-width: none;
	}
}

.jss54 {
	width: 100%;
	margin: 0 0 1rem;
}

.jss54 path {
	transition: fill 0.3s ease-in-out;
}

.jss54 form {
	border: 1px solid white;
	display: flex;
	border-top: 1px solid rgba(0, 0, 0, 0.04);
	box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.12);
	transition: box-shadow 0.3s ease-in-out;
	border-radius: 4px;
	flex-direction: row-reverse;
}

.jss54 button {
	border: none;
	outline: none;
	padding-left: 1rem;
	background-color: transparent;
}

.jss54 img {
	height: 1.25em;
	display: block;
}

.jss54 ::-webkit-input-placeholder {
	color: #DDD;
	transition: color 0.3s ease-in-out;
}

.jss54 :-ms-input-placeholder {
	color: #DDD;
	transition: color 0.3s ease-in-out;
}

.jss54 ::-moz-placeholder {
	color: #DDD;
}

.jss54 :-moz-placeholder {
	color: #DDD;
}

.jss54 input {
	width: 100%;
	height: 2.5em;
	padding: 1rem 0;
	font-size: 1rem;
	border-left: none;
	border-radius: 0 4px 4px 0px;
}

.jss55 form {
	box-shadow: 0 1px 2px 1px rgba(0, 0, 0, 0.2);
}

.jss55 form ::-webkit-input-placeholder {
	color: #A8A8A8;
}

.jss55 form :-ms-input-placeholder {
	color: #A8A8A8;
}

.jss55 form ::-moz-placeholder {
	color: #A8A8A8;
}

.jss55 form :-moz-placeholder {
	color: #A8A8A8;
}

@media only screen and (min-width: 768px) {
	.jss54 input {
		height: 3.5em;
		font-size: 1rem;
	}
}

.jss2 {
	display: flex;
	overflow: hidden;
	justify-content: center;
}

.jss3 {
	display: grid;
	-ms-grid-rows: auto 1rem auto 1rem auto 1rem auto 1rem auto 1rem auto
		1rem auto;
	-ms-grid-columns: 1fr;
	grid-template-areas: "adSectionTop" "main" "adSection4" "nutrition"
		"activity" "adSection5" "blog";
	grid-template-columns: 1fr;
}

.jss3>div {
	margin: 0 1em;
}

.jss3>section {
	margin: 0 1em;
	padding-bottom: 1.5em;
}

.jss3>.jss13 {
	margin-left: auto;
	margin-right: auto;
}

.jss3>div:not(.jss6) {
	padding-bottom: 1.5em;
}

.jss4 {
	grid-area: main;
	-ms-grid-row: 3;
	-ms-grid-column: 1;
}

.jss5 {
	grid-area: sidebar;
}

.jss5>* {
	margin: 24px 0;
}

.jss5>*:first-child {
	margin-top: 0;
}

.jss6 {
	grid-area: adSectionTop;
	grid-column: 1/-1;
	-ms-grid-row: 1;
	-ms-grid-column: 1;
}

.jss7 {
	-ms-grid-row: 5;
	-ms-grid-column: 1;
}

.jss8 {
	grid-area: adSection5;
	-ms-grid-row: 11;
	-ms-grid-column: 1;
}

.jss9 {
	grid-area: tabletAds;
}

.jss10 {
	margin: 1rem 0;
}

.jss11 {
	grid-area: nutrition;
	-ms-grid-row: 7;
	padding-bottom: .875em;
	-ms-grid-column: 1;
}

.jss12 {
	margin: 10px 0 !important;
	padding: .875em 0;
	grid-area: activity;
	min-width: 0;
	-ms-grid-row: 9;
	-ms-grid-column: 1;
}

.jss13 {
	margin: auto;
	padding: .875em 0;
	grid-area: blog;
	max-width: 425px;
	-ms-grid-row: 13;
	margin-bottom: 4.125em;
	-ms-grid-column: 1;
}

@media screen and (min-width: 768px) {
	.jss3 {
		margin: 2em auto;
		display: grid;
		-ms-grid-columns: 1fr;
		grid-template-areas: "main" "tabletAds" "nutrition" "activity" "blog";
		grid-template-columns: 1fr;
	}
	.jss3>div {
		margin: 0 3.625em;
		padding-bottom: 2.5em;
	}
	.jss3>section {
		margin: 0 3.625em;
		padding-bottom: 2.5em;
	}
	.jss3>.jss13 {
		margin: 0 3.625em;
		padding-bottom: 2.5em;
	}
	.jss4 {
		grid-area: main;
		-ms-grid-row: 1;
		-ms-grid-column: 1;
	}
	.jss11 {
		-ms-grid-row: 3;
	}
	.jss9 {
		display: flex;
		-ms-grid-row: 5;
		-ms-flex-pack: distribute;
		justify-content: space-around;
	}
	.jss10 {
		margin-top: 0;
	}
	.jss12 {
		-ms-grid-row: 7;
	}
	.jss13 {
		width: auto;
		max-width: none;
		-ms-grid-row: 9;
	}
}

@media screen and (min-width: 1024px) {
	.jss3 {
		display: grid;
		padding: 0 1rem;
		grid-gap: 2rem;
		max-width: 1024px;
		-ms-grid-rows: auto 2rem auto 2rem auto 2em auto;
		-ms-grid-column: 1fr 2rem 300px;
		grid-template-areas: "main sidebar" "nutrition sidebar"
			"activity sidebar" "blog sidebar";
		grid-template-columns: 1fr 300px;
	}
	.jss3>div {
		margin: 0;
		padding-bottom: 0;
	}
	.jss3>section {
		margin: 0;
		padding-bottom: 0;
	}
	.jss3>.jss13 {
		margin: 0;
		padding-bottom: 0;
	}
	.jss11 {
		grid-area: nutrition;
		-ms-grid-row: 3;
		-ms-grid-column: 1;
	}
	.jss12 {
		grid-area: activity;
		-ms-grid-row: 5;
		-ms-grid-column: 1;
	}
	.jss4 {
		grid-area: main;
		-ms-grid-row: 1;
		-ms-grid-column: 1;
	}
	.jss13 {
		grid-area: blog;
		-ms-grid-row: 7;
		-ms-grid-column: 1;
	}
	.jss5 {
		-ms-grid-column: 3;
		-ms-grid-row-span: 6;
	}
}

.jss60 {
	padding: 16px 4px;
	position: relative;
	font-size: 14px;
	
}

.jss61 {
	bottom: 1px;
	margin: 0;
	position: relative;
	font-size: 20px;
	font-weight: 600;
}

.jss62 {
	float: right;
}

.jss62>* {
	right: 16px;
}

.jss63 {
	top: 50%;
	right: 0;
	position: absolute;
	margin-top: -64px;
}

.jss64 {
	font-size: 16px;
	margin-bottom: 0, 4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px, 80px,
		104px;
}

.jss64 a {
	font-weight: 600;
}

.jss65 {
	margin-bottom: 0, 4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px, 80px,
		104px;
}

.jss66 {
	top: 5px;
	position: relative;
}

.jss67 {
	margin: 0px 4px;
	display: inline-block;
}

.jss68 {
	color: #f2f2f2;
}

.jss69 {
	top: 50%;
	right: 0;
	position: absolute;
	margin-right: 24px;
}

.jss70 {
	margin-right: 80px;
}

.jss71 {
	font-size: 14px;
	font-weight: 600;
	user-select: none;
}

.jss72 {
	color: #aaaaaa;
	cursor: pointer;
	margin: 0px 4px;
	display: inline-block;
	padding: 4px 8px;
	text-align: center;
	border-radius: 3px;
}

@media ( min-width :992px) {
	.jss72:hover {
		color: #222628;
		text-decoration: none;
	}
}

.jss72:active {
	color: #fff;
	background-color: #000;
}

.jss73 {
	color: #222628;
}

.jss74 {
	top: 4px;
	color: #222628;
	padding: 0;
	position: relative;
}

.jss75 {
	color: #9CA2AF !important;
	cursor: not-allowed;
}

.jss75:active {
	color: #9CA2AF !important;
	background-color: transparent;
}

.jss76>* {
	cursor: wait;
}

.jss77 {
	top: 3px;
	position: relative;
	pointer-events: none;
}

.jss1 {
	margin-top: 1em;
	text-align: center;
}
</style>

<title>食物區</title>
<script>
	window.onload = function() {

		var sendData = document.getElementById("sendData");
		sendData.onclick = function() {
			if (confirm("請問是否確定送出?????")) {
				var eatValue = document.getElementById("eat").value;
				if (!eatValue) {

				}

				return true;
			} else {
				return false;
			}

		}
		let showimg = document.getElementById("showimg");
		//以mbid
		var xhr2 = new XMLHttpRequest();
		let url = "<c:url value='/memberManagement/' />" + "${mbid}";
		xhr2.open("GET", url);
		xhr2.send();
		xhr2.onreadystatechange = function() {
			if (xhr2.readyState == 4 && xhr2.status == 200) {
				//console.log(xhr.responseText);
			}
			var imageURL = "<c:url value='/getImage' />";
			showimg.src = imageURL + "?mbid=" + "${mbid}";
			showimg.style="";
		}
	}
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/memberCenter.css">
<style type="text/css">
#mainNav {

  background-color: #212529;
}

</style>
</head>
<body style="text-align: center;">
	<%@ include file="../../../navigation.jsp"%>
	<!-- Navigation-->
	<div class="navbg"></div>
	<!--content 請將以下div刪除改成自己的內容-->
	<div class="mainContent" >
		<!-- 側邊欄 -->
		<div class="sideNav">
			<div class="memberImgBox">
				<img style="display: none;" src="${pageContext.request.contextPath}/images/member_0.png"
					id="showimg" alt="memberPhoto" class="memberImg">
			</div>
			<div class="memberHelloBox">
				<span class="hello_text">Hello！${user}</span>
			</div>
			<div class="line"></div>
			<div class="linkBox"></div>
			<a href="<c:url value='/memberCenter_editInfo'/>" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-01.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">會員資料</span>
			</a> <a href="<c:url value='/addMemberForm' />"
				class="link link_here"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-02.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">健康紀錄</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-03.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">文章收藏</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-04.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">購物車</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-05.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">訂單查詢</span>
			</a> <a href="#" class="link"> <img
				src="${pageContext.request.contextPath}/images/memberCenterIcon-06.png"
				alt="memberInfo" class="linkIcon"> <span class="linkText">預約諮詢</span>
			</a>
		</div>

		<div width="50%" style="margin-left: 100px;">
			<section class="jss10" style="padding-bottom: 20px;">
				<div class="jss54 "
					style="width: 652px; height: 30px; margin-left: 100px;">

					<form action="<c:url value='/healthCenter/food/all/' />"
						method="get">
						<input type="search" placeholder="         搜尋食品" maxLength="45"
							class="jss58 jss57" value="" name="eat" />
						<button type="submit" id="sendData">
							<svg xmlns="http://www.w3.org/2000/svg"
								xmlns:xlink="http://www.w3.org/1999/xlink" width="24"
								height="24" viewBox="0 0 24 24">
                                                
                                                    <g fill="none"
									fill-rule="evenodd">
                                                        <g
									transform="translate(-16 -16)">
                                                            <use
									fill="#4C4C4C" filter="url(#a)" xlink:href="#b"></use>
                                                            <use
									fill="#FFF" xlink:href="#b"></use>
                                                        </g>
                                                        <path
									fill="#4C4C4C" fill-rule="nonzero"
									d="M16.27 15.094h-.201l-.385-.37a8.88 8.88 0 0 0 2.155-5.805A8.92 8.92 0 0 0 8.919 0 8.92 8.92 0 0 0 0 8.92a8.92 8.92 0 0 0 8.92 8.919c2.209 0 4.24-.81 5.804-2.155l.37.385v.2c0 .566.225 1.108.626 1.508l5.212 5.202a1.447 1.447 0 1 0 2.047-2.047l-5.202-5.212a2.13 2.13 0 0 0-1.508-.626zm-7.35 0A6.167 6.167 0 0 1 2.743 8.92 6.167 6.167 0 0 1 8.92 2.744a6.167 6.167 0 0 1 6.175 6.175 6.167 6.167 0 0 1-6.175 6.175z">
                                                        </path>
                                                    </g>
                                                </svg>
						</button>
					</form>
				</div>
			</section>
			<c:forEach items="${foodlist}" var="food">
				<div class="jss60 "
					style="margin: 0 auto; width: 50%; text-align: left; padding-bottom: 30px; margin-left: 120px;">
					<div class="jss64">
						<a target="_self"
							href="<c:url value='/healthCenter/record' />?foodid=${food.foodid }"
							style="color: blue;"><c:out value=" ${food.category }" /></a>
					</div>
					<div class="jss65">
						<c:out value=" ${food.name }" />
						,
						<!-- -->
						<c:out value=" ${food.weight }" />
						<!-- -->
						<!-- -->
					</div>

					<div class="jss70"
						style="border-bottom: 3px solid gray; width: 600px">
						卡路里：
						<c:out value=" ${food.calorie }" />
						<!-- -->
						<span class="jss67">•</span>碳水化合物：
						<c:out value=" ${food.carbohydrates }" />
						公克
						<!-- -->
						<span class="jss67">•</span>脂肪：
						<c:out value=" ${food.fat }" />
						公克
						<!-- -->
						<span class="jss67">•</span>蛋白質：
						<c:out value=" ${food.protein }" />
						公克
					</div>
					<div class="jss63">
						<div class="root-2XVjd">
							<div class="recharts-responsive-container"
								style="width: 100%; height: 100%; min-height: 1px">
								<div
									style="position: absolute; width: 0; height: 0; visibility: hidden; display: none">
								</div>
							</div>
							<div class="label-1frn-"
								style="text-align: center;width: 60px; height: 62px; line-height: 62px; border-radius: 30px; font-size: 40px; background: #ffd306; color: #ff;">
								<span class="jss61" style="text-align: center;"><c:out
										value=" ${food.calorie }" /></span>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>


		<!-- 				notes-v2 -->
	</div>

</body>
</html>