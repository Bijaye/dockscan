class ReportHTML < Dockscan::Modules::ReportModule

	def info
		return 'This plugin produces HTML reports'
	end
	
	def file_extension
		return ".html"
	end

	def format
		return "html"
	end

	def htmlhead
		htmlout = ""
		htmlout << "<HTML><HEAD><TITLE>dockscan Report</TITLE>\n"
		htmlout << '<style>'
		htmlout << '.Vulnerability {
	margin:0px;padding:0px;
	width:100%;
	border:0px solid #000000;

	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;

	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;

	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;

	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}.Vulnerability table{
    border-collapse: collapse;
        border-spacing: 0;
	width:100%;
	height:100%;
	margin:0px;padding:0px;
}.Vulnerability tr:last-child td:last-child {
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
}
.Vulnerability table tr:first-child td:first-child {
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}
.Vulnerability table tr:first-child td:last-child {
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
}.Vulnerability tr:last-child td:first-child{
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
}.Vulnerability tr:hover td{
	background-color:#ffffff;
}
.Vulnerability td{
	vertical-align:middle;

	background-color:#ffffff;

	border:0px solid #000000;
	border-width:0px 1px 1px 0px;
	text-align:left;
	padding:7px;
	font-size:10px;
	font-family:Arial;
	font-weight:normal;
	color:#000000;
}.Vulnerability tr:last-child td{
	border-width:0px 0px 0px 0px;
}.Vulnerability tr td:last-child{
	border-width:0px 0px 0px 0px;
}.Vulnerability tr:last-child td:last-child{
	border-width:0px 0px 0px 0px;
}
.Vulnerability tr:first-child td{
	border:0px solid #000000;
	text-align:left;
	border-width:0px 0px 0px 0px;
	font-size:14px;
	font-family:Arial;
	font-weight:bold;
	color:#000000;
}
.Vulnerability tr:first-child:hover td{
}
.Vulnerability tr:first-child td:first-child{
	border-width:0px 0px 0px 0px;
}
.Vulnerability tr:first-child td:last-child{
	border-width:0px 0px 0px 0px;
}

.VulnerabilityBLACK tr:first-child td{
	background-color:#000000;
	color:#FFFFFF;
}

.VulnerabilityRED tr:first-child td{
	background-color:#ff0000;
	color:#ffffff;
}

.VulnerabilityORANGE tr:first-child td{
	background-color:#ff9966;
	color:#000000;
}

.VulnerabilityYELLOW tr:first-child td{
	background-color:#ffff00;
	color:#000000;
}

.VulnerabilityGRAY tr:first-child td{
	background-color:#d0d0d0;
	color:#000000;
}
'
		htmlout << '</style>'
		htmlout << "</HEAD>\n"
		htmlout << "<BODY>\n"
		htmlout << '<img width="220" height="169" title="" alt="" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAANwAAACpCAYAAABAtVPzAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAa8klEQVR42u2deVhTV/rHv1lJIEACKLuA4IIgm0vdUKvjNtpWa9W2aqfV6jjTjr+22mpXtavdpu1Ml+lmrbaOdmrt4laV1loFpQiCKCirhFWWICEkhCT390cgEJMACSQEfD/P4/NI7nLOPfd87/ue7T0shmEYEAThENhUBARBgiMIEhxBECQ4giDBEQRBgiMIEhxBkOAIgiDBEQQJjiAIEhxBkOAIggRHEAQJjiBIcARBkOAIggRHEAQJjiBIcAQx8OFSETieJz9LR1ZRvdXXvbE6HrFDJVSAZOEIgiDBEQS5lMStQp28GS0aHQDAVyKkAiHBEfbktX2XDG3Vn1+ZQQVCLiXhKBqVLVQIZOGInrqK5pCIXMDnGX/LFSoNREIeCY6qD9ETV9Ec5oYvbihaqB1HgiN6k6H+IoT7i+Dlzjc5plRrqYBIcH3D0qkhmJXgb/V1wYNcnSL/Ty+LQotGh0+O5OP0pWrD77FhYiyaFAwAqJIpoe7gdsoa1fTiSXB9w7jh3v06/17uLgAAoQvH6PcDyaU4kFxq9hp1J20+EhzRIzILZVZP3Vo0KQgiIQ/H0itQJVNZnaavRIDZNlhNR1Fzo5kqBgnOPmQV1eOrX4qsumZ2gh9EQh6Op1fYNM8yJkzscMHNHROAmDDzczul1Qp8c6rE8LdWR9sQkuCIHhEdKkZ0qNiile8ouKp6JRUYaOCbcBCXim/grf2XsfN4AVk4Z+bVvdk293AtnRqCccO98dGhqyisaOy1PI0d5o1l00IGTCWokzdDWt3Ua/cz15taXqdEeZ0S21bG9Gq6IiEX4f7uJLjeIlfagKp6lU3XtnW9F1Y02tQu6qyDYiBxILkU35y61mv3iwkTY8WMMNP3Ee+HCSN9DH+n5dXh7f05PU7rzYcTyKUk+g/Jl6t79X5ZRfXIkTZAwG8fNvDxcMG6+cNu+bJ2Sgv3xCfnDd3I1Q32704W8DlIjB7U7fOjQsQDpgJUypQorWnq9fseTSvHluWjse3ri1CptVg3fxjNpXRWwdXcaLbZjTTy7wX6x3t6WRRqGprxwq4sk/Ygm83CluWjkRDhdUtWgHO5tXa5b0WdErnSG3jlwVgcO1+BxOjB5Eo4UnDp+XV490CuxeNuAi7eWzfWZJa5LUyM9MHKmWGGxrSQz8V/DpnvfFl/14hbVmwAkJJTbbd77ztVgrljA/DE3ZGkNEcLLquovkur9e3pa7j/9jC4CWzLVltjveNMdWWzFs9+eQGXrt0wOX/p1BDMGxvQ68+6cmYYVs4Ms+laR3YAKJu1yDZTLr2FSq3Fjp8LsPGeUaQ0Rwsur6yhy3O+PS3FnROCcN/toXjlv9k9rqxaHYOX/nvRrNgA4JtT13q1d44w5XhGJe6cEIThQR5UGI4UXI60a8EpVBrs/qUIf5s/HN+HeFoUSnfQ6hi8ujcb5/Pq6C33Ma//7zIihxgLbs3cCBKcvZBWK6BQabp17qHUciyaFIw1cyPw2MfnbU7z1b3ZRktHiL6jtKbJpCd05YywXrl3lUyF3Unm560GeAsxM87v1hNcd6xbGy0aHb5KKsLGe0ZhRqwvfsmssjq9jw7lkdhuEarqVRYnigv4HCRGDe6VjrjewiE56U77rSNJmVUoqJDjL7OGgse1Lov7fruG75OlVBMJqNRapOXVOlWeHCK47GLr2mI6HYOdxwvhJxFi0aQg69zXGgXVNMLA79nXby2XUt2iQ/F160WQeqUWmYUyLJsagqNpFWho6lmYtbfXJmCQhwvVQAdyMLW8z3uBk3NqoG7ROY1baXfBXS1rgM7GxYc7jhXgvXVj8Zc/DcW/f7zSo3wM8nChqFEOZvWccAQPcsU7B3JtrgO95VZOGjXIKcrE7rLPK5PbfG2utAFnLldj3rgABPm4Ug3uh8xO8MebD8dDIuKTW+kIwWVf69mymE+P5AMA1sxz7nEbXU0edKWp7f/qCsE0NzhN/hilzDh/Vdlg5JUOSTs6RIx3141ByGC3PnUrB7RLmV1cj6Pny3u8Dq2iToltX2XBw40HHpfdacTfzEIZZHLzi1VvNPV+IFJG0wxt2mfQZO4BVBaek+8OlncE2IEJYAdPBDtoHFhsx80Z1xaehCblX2BqLLjkLA5YkjCwfaP0+QufCRa/970JP4kQ760bi1f3ZSP1imN7Dp3JrWQxDGMX53p3UpHVgXTsybBAd7y3biw4bFbviE1RA/XBf4CpzLLuQpEvuDH3gxOzFCwX+053ajn9T2jPf27dRRw+2CPvADf2PrAH9f6kY21rD/SC8QHILKrv8QLU7jIj1heblkYNXMH964dcHEotdyq3b8WMUKycObTn7mNpKlqOPQtG3oPn4/D1FsU/BiyRH+DqDbZvNFhCSa98DFp+2QZd4S89qxx+MWAHJIAlCQNLKAHLcwjYPr23iPRYeoXDBCfgc/C/ZxL7vLfSbr6NMwb+3HPyGiaNGtStGBiMogaMrFD//2Y50CyHrr4EOmmK9VbN7KdeDV3xb9AV/2ZcyQdHgTtxPTihUzrPX3MDmPoSoKUJjKYZaKrVt9OuX4KuIAnQ9jzSMVOZBe3NzyoQgxu/EpyxD/fYNRbyOfAVOy5cRY70Rp9v2Ww3C/fW/ss4nl7pdKIb6ifC+4+MM+taMkoZNGmfQXv1CNBY1YdvhQP+AwfBFg8xOaS5/D20mXvAXL/Ut1/qSY+DO+5hEE5i4ZyVwspG7Pm1yMS1ZBrK0LzvPqCpvUHPDp0GZdB0qDQMvBS50GbvB5iebUrBjpgFuV8iAMC9OhW6KwfNmBYtmPJ04CbBqQ89Bl3+8XZdugeAiVqKsmYRQoQKaC7sMsq/TVqXhIGJvg9VTWwE8m9Ac34noDYd2tFdOw3YKDitjsHv2dcd7gV5uPIg5HO6PM/H0wWB3q79S3C+YucdZDbnWraceceosjLxq7B+Tx727l0LAIiLi8PXL22Ed/rrNqeriluHdR+dwcGDfwGXy8X06dOxc/OTEJx7s+tKWpBkLDafEfiRtRB/m/8EBAIBNBoNvvjgLczgfGlz25LlH48dVQl4fvb/gcvlQiQSYcc/X8D4io9Ne2HZHJvSKKiQ461vc1BY2eiUdWPa6MFYf9cIu93fbi3Ivhzo7LLTQ8fg9W8uG43NMNUdwj+IfPHBWQ2ys7NRXFyMmpoaREdHY8MHh8EOnWZbZfaKwPYjZVCpVKipqUFlZSXEYjGe+yoNLL8Y0/MHG/eoGeUPQGnwEqz5+3qcOHECpaWl2Lt3L1b+9TE0Rj1kc7lc8rkbz297FSdPnkRlZSVefvllLF37FDRxq810qMRabdV2JxXi0Q/TnFJsbgIunloyCs/cG23XYEd2E9zwQOcOznntugI7T7RHAWYFtK8WZ/vF4Oix43juuecgFovB5XKxfft2HD16FOwA20IgsH2jcfbsWWzduhUCgQACgQCbN2/W3zNonPG5wRNMegNvFuWpfAUWLFiAuLg4AMD06dMRHR2NrCobm+R8dxxLvYoHH3wQ0dHRAIB7770XQUFBuFxzUzXhCcEZtdAqq/boB3/gq1+K+2yKV2dEhXjiw0fHOWTtnN1cylBfEQR8DlROvBHfgeRSJEYNRuQQT/CmbobG1Qe6giQwjVUICgpCdnY25s6dCwBIS0tDUFAQGG0zWO42xEFhcyASiZCWlmYQSXZ2Nvz8/AB1E8ATAho12CFTwPvTiyaXc0ITgblvQnvxG+iqc+ErUCM3t93qaTQaFBcXw9vdxbb8AfD1keDkyZOGvxsbG1FcXIzAQZ5AuTfQVAuWVwS4iU+a7dC5GXWLDntOFmHfqRKnFBqbzcLKGWFYNi2k18Znu/R07NVLCQBbv8pCSk6NU1u6IB9Xsz57bk4Otj71KO66YzbEYjF2f70PK9c+gXnzF9ic1h+pqXhj21O4+655EIlE2Lnrv9jw/HZMmjzF6ntpNBo8/cQ/wNbUY8GCBdi7dy/8QmPx/Isv297GVKmw4ZE18PMWYMqUKdi/fz/Coyfj8Sc3WX0vhUqDz38usEvMy94gwEuIp++NwvBAx8ZasavgzubWYMvuLPRXuGwGnLpcqJubIPCPhVLXc4eAz9YBtZeh0bSA7xsDlY7To/u5qSshry6Cu98IKDi9E+7PXV2OG9XX4BkQBTlr4AX/mTvWH+v+PNxkQ8l+LzgA+Nu/U522R4q4tfBw5eHxRSP7dE6l3ee5rL9rBNgO8o8JwhJx4RJ8+Oi4Pp/AbHcLB+jjjOw4Zp99wdwEXMNG7gUVckObcVa8n2F1QNsk6qH+IkyK1Bd4ck61YQurtp1eqmRKHM/Qz46ZGOljGKc7kCyFQqWBr1hg2JGnY1qLJgXBTcAzSismTGzYHbQtrY557ZhWx7y2pdUxr1lF7VsYt+VVoWox7KfdMa3j6RWoqlfZrVz6GzwuG6tnh2PR5GDnaKY4IpFl00Kg1ujssnpAyOdgdoK+O/f3bLahYo0d7o3IYA+jihXgJTScW1zVaKhYbb/lSBsMFSs6xNMQD/9oWjkUKg0k7nyzaU2JHmwI39CWVri/yCStjnntmFbHvLal1TGvClWLQXBtv1U3NBsE1zGttLxaVNWr7FYu/YmQwW7YtHSUU+0f5xAL17ET5cOfrvbKRh09xdpJszfnubvThNqoa1QbreUT8DnwdO3+AKtSrTWJ69LTZ5CI+OBbERXt5mdwZhZOCsLq2RFOFSLP4YID9GMzJy9W4WhaOXKkDX02PvPzKzOsOn/Os8ZLXTYsjrRqE/snP0s3Wow7K8EPGxd3P+a+uaUsPX2GN1bHWzV7/uZncEYkIj42LI7EuOHeTpk/h09e5vPYmJ3gj9kJ/lA2a1Fc1QhpTRN2Hi9ErQP2gmvDUrTe7pJ8uRpVsu5b6pvPLahotCoPBRXyXn+G4+kVVgnImuftCyZG+uDxRSPh6ea80wodbuEs8cCbyU7hahL9DwGfgzXzIrBgfKDT59VplucED3IlwRFWMyzQHZuWjELwILd+kV+nEdzSqSFIL5A55Zw7wvlgs1m4Z0owHpwV7rB5kAPKpQT0Ube+PFHYo22qiIGPr1iADYsj+zxcQr8XXBvKZi0amtRoVGnQqNQ4JE0+lw0vd/6AqJACPsepOw5uZZxScAQxYF1hKgKCIMERBAmOIAgSHEGQ4AiCIMERBAmOIEhwBEGQ4AiiP9NvNvPY9lUWkrsZ45LFAv7vrhGYN87ycg2lWovndl5AtoV5mxw2C8/cG4UpUYMt3qOoQo4nP8+A3ML0szkJ/njs7pFgs9on1xZUyPH39/8we/4jC4bjzolBAIBPDudh/xmp2fM+eGQcIgL0YQO+/f0aPj1qOV6Mv5cA21fFw8/C7q8Mw+C973NxJK3C7HF3IRfbV8Ub0jPH+o/ScKW0wex7+N+ziXDvJHS4pfIYE+GFVx+KM/n9SFo53j2Qa/J7QoQXXjNzPlk4B8AwwHvfX8FP50rNHm9u0eKFXZkWxQboY+G/tvcSUnKqzR6XViuw+YsLFsUGAD+nV+Cd73LttgJi36nOxQYAFXUqbPgk3WJA1v8cyrMoNgCQKzXYtCMDeWUNNr2HrEKZTc92Pr8OlwfgJHbO1q1bt/aXzIb6igC0x+ZYMSMMMWESk3+VMhUUKg1Sr9TC3ZWLkcGeRmLbsjsLmYX1rV9GCWbG+RtdP2qIJ/LL5VBrGZy+VI2IAHcE+bRvX1Req8RTn6VD1tgCFgtYODEIY4d7G92jpqEZcqUGBRWNuF6vMgrPJuRzERMmMay2jgkTY1aCP2LDJPDxdDGc5+3hglxpAxgGiG09JyZMgtihYnyfUoovjhUarNCSxCGIHWpcDiIhF9LqJjQ1a3EquwrjhnlD3GGTlc9/zjdY0XB/EeaPDzS6PtDbVV8OGh1OXbyOMcO84OXuYvbdRAS4g8XSrwpns4C2T4ynGw/jR/h0+l5vLo82qutV+FO8aRiLtjxU1asMZRcTJsFQfxG5lL3F9BhfAMDuJBhezMqZYWbPnZ3gh6c+z0ClTIWPDuZBp2Nw92R9LPwDyVJkFOi/uhNG+uD5+6PB5Zga+vgIL7ywKxPNLTq89PVFHHzxdsOxTTsyUCvX7zD6jztHYL6ZlcZzx/pj46fpqJSpcDyjEhvvGWWoLG35bg+pJzF5lvgILxz+oxxaHYOIAHe8+EAsBB2CFu08rheb2I2H7aviEeYnMusufnw4HweSpahvbMHvl6oR2nresfMV+OZUSeuHzA3bV8XDw0xQo8FiAb48UYhGlQYpOTVmXct54/R7GWzZrQ8DMTPODycuVIJhgAsFnVs4c+XBZbOg0TFIL5Ahu7ge0aFiw/nDAtwxLMDdUA/MlR25lA7GVyLEW2sSEOCtb7d8fDjfcKxF0+7ePXefebEBQNxQiSGuY4vW2CW83mph548PMCs2ABjkKTD7de4unx7Jx+lL1RgsFuClB2KMxNaRBbcFmRWbvg3Fwrr55vfk7ri6/rWH4syKDQDuvz20W/nVanXIKpIZPo4RraHpSqqbUCe3LlbNnLHt5dbTuC0kOAcxyFOAGbGdbz/E6yJEnCUxtiERudgl7z+kSPHdGSncBFy8/ECMRTeuuwR4CRHgJYS7kGvRyvSU3NIGNDVrweOwMDpMjISI9n0OurJyJiKfHmp4NxcKZbhYJCPBEV0j4LMhduNB7Nb9+JMpOdX4z6E8cNksvHB/NEJ8e94u+WLDRHyxYSIWTrIt+nDbMwj4lqtLen4dACAqRAwXHsdYcFZ2nPh4CrBgfPuWW7sGkJXjkizsx5LEECxJDOn2+VdLG/DavkvQMcCDs8IQF971bjiOWD+875nELs9pE1zCMK9W4XnChcdGc4vOagsHAMumheLIH+VQteiQVVSPzEJZvwypQBbOSamsU+L53fpOGkAft7I7/Hi21OwYmCNRqDTILdV3mIxptWw8LhujWzs7qupVqKhTWnVPiYhvGJPUW7lCsnBE79CobMFzuzJR39gCkZCLRqUGv2dfR6VMaXHAevGUYOw/LYVcqcH6j9I6vf/SqUOwek6E3fKfWaiPtubpykN4h675hAgvpOXVtbbj6uDvZV3cyCWJITh4rgxNzVpkF99ARkEd4sO9+vW7JgvnBPx4thTS6ibcHuuLLctHAwB0DHDAwkwTAFg7bxiWTeueu/rNqRK8e8B+A/Bt7mR8hASsDrNqOrbj2sY9rcHDlWcYzgEGRo8lWTgnQMfohyE2LI4Ej8NGZLAHcqQNOHq+AitmhlmcGrVqdjiCvC0H0GUYBj+dK0NDUwuOpJUjeJArFk8ZYjfBdRQYoB/fk4j4kDWqkVEoA8MwRoLsDndPDsYPKXpLfunaDaTn15mkQ4IjrCLU1w0vLB8NXuswxNKpIdj29UWo1FocSi3DvdNCLV47e0znY32J0YOx7t+pAICmZm2v571KpkJZrdKs4FgsFhIivJB0oRL1jWqUXFdY3evqJuBiSWKIYX/BXUmFJDjCPFekDYYOjY4dADczJWow3ATtr2JCpA+CfFxRWtOEH1JKsXjykC7HDC1haVDcKpc3RT8ndUSQB0YEG+/5nV5QZ/j/ijeSO73PhUKZTcMcd00MwnfJJahvbEFOSQPSrtZSG44wJfVqLT44eBUfHLxq3UthsbAkUe/61cnV+DWzyuScFW+cwYo3zuC7MyV2f462Z0g1U9Hb3MnukFFg2wC2gM8xsvK7f+m/bTmycE7KzDg/fHmiEHVyNfafKcGsBD+j9k/1Df10KYVK22d51DEMMloFt2pOOJZNDTHbjlz+xhnUNqiRVVQPnY6xac/3+eMD8e3vJahpaG6d0N0/4xcPWAtXcl2Bw3+U6b8qHPMvWKHqPIx6V8e7HluyvVLwuGzDXM7iKgXO59VZ7BjpNAfdqJidPUdn1+eXyw3LkyZYWBHAYrFwW+sxhUqDvHK5TeXB57KN5nVeKZWT4JyFggo5Nn6ajjq5GjwOy9DVDgAeru1G/ZmdF9BkQVS/ZlbihxR9t/zNcxCHB+on5iZdqMSeX827N9JqBQ6eK+vRc8wfHwhXF/2k5W9Pm3cdf0gpRa7U/LoxnY7BO9/ldqj87ceGBbob/t60IwPVN8z3dH50KM9i/trcST+JACG+lreLum2kT4d2XJ3N5TFnjD/8JIJ+XTf7jUt5MqsK0uomw4x0wPy4DMMw+OFsKRqVGvC4bGxZHo1xw9tf+B0TgpBf3ohj6RXIlTZg8xcXTLanVTZrcCClFDoGEAm5eH1VvNHxVx+Kw1OfZ6CwohFfnijC9fpmeHsYTwA+/EcZ6hX6PblXzwk3/F4nb8ah1HKjc7OKZNidBIwZ5oVRQ/Rr987n1eJySQMGiwUorlIgo0CGz47mw4XHwfzxAfjrnyPw8eF8NKo02LzjAhZOCgKHbfz9zCtrwLkr+nbXUH8R7ritfeB5wkgfPLZwJN49kIsqmQqbPs/A7TdN9i6racKvWfr2Y4C3EPPGBaBFq8Pek9cAAKcu6o8J+RzsTirC5FE+GHrTBvbfJ0tR02Fn26SMKqhb9FZz8ZTg1p5Y4/LYnVQEVxeOyRAGl8PG8hlhJlsv9yf6zWYe1oRYaHNBtiwfjbFm9nrW6Ri8vT8HJy5UdnoPNwEXr6+Kw7BAD5NjNxRqbPwsAyXXFZ3e4+G54UbzKTsLsbB2XoShknUnxMLB1DK8/+MVdPUGhwW447WH4uBuZgnOT2dL8f5PnXfqBHoL8ebDCfD2cIFSrcXCbb+ZPe/JeyJNliQ99HYKyi24rHs2TUa9Qm22PHw8XPD1pskmv2t1DNa+d86wgn3FjDBaD9fX8LlsbF1hXmyAfjO/DYsjMSPW1+I9XF04eO1B82IDAE83Pl5fFYdAb6HFe6y5SWy9zYLxgdi4OBKd9UGMDPLA9lXmxdZm8dfOszztK9CnXWzOAIfN6lcC67cWjiAGAjQORxAkOIIgwREEQYIjCBIcQRAkOIIgwREECY4gCBIcQZDgCIIgwREECY4gSHAEQZDgCIIERxAECY4gSHAEQZDgCIIERxAkOIIgSHAEQYIjCIIERxAkOIIgwREEQYIjCBIcQRAkOIIgwREEQYIjCBIcQZDgCIIgwREECY4gCBIcQZDgCIIERxAECY4gSHAEQZDgCIIERxAECY4gSHAEQYIjCIIERxAkOIIgSHAEQYIjCBIcQRAkOIIgwREEQYIjCBIcQZDgCIIgwREECY4gCBIcQZDgCIIgwREECY4gSHAEQfQq/w9oL6HJcEfn7wAAAABJRU5ErkJggg==" />'
		return htmlout
	end

	def htmlfoot
		htmlout = ""
		htmlout << "</BODY>\n"
		htmlout << "</HTML>\n"
		return htmlout
	end

	def report(opts)
		output=""
		output << htmlhead
		output << "<h2>dockscan Report<h2>"
		issues = sortvulns
		7.downto(3) do |sev|
			if issues.key?(sev)
				output << "<h3>" << sev2word(sev) << " vulnerabilities</h3>\n"
				issues[sev].each do |v|
					if sev >= 7 then
						output << '<TABLE CLASS="Vulnerability VulnerabilityBLACK">'
					elsif sev == 6 then
						output << '<TABLE CLASS="Vulnerability VulnerabilityRED">'
					elsif sev == 5
						output << '<TABLE CLASS="Vulnerability VulnerabilityORANGE">'
					elsif sev == 4
						output << '<TABLE CLASS="Vulnerability VulnerabilityYELLOW">'
					elsif sev == 3
						output << '<TABLE CLASS="Vulnerability VulnerabilityGRAY">'
					else
						output << '<TABLE CLASS="Vulnerability">'
					end
					output << "<TR>\n"
					output << "<TD COLSPAN=2>" << v.vuln.title << "</TD>\n"
					output << "<TD>" << sev2word(v.vuln.severity) << "</TD>\n"
					output << "</TR>\n"
					output << "<TR><TD COLSPAN=3>" << v.vuln.description << "</TD></TR>\n"
					output << "<TR><TD COLSPAN=3><PRE>" << v.output << "</PRE></TD></TR>\n"
					output << "<TR><TD COLSPAN=3>" << v.vuln.solution << "</TD></TR>\n"
					output << "<TR><TD>CVSS: " << getkey(v.vuln.risk,"cvss").to_s << "</TD><TD>State: " << v.state << "</TD><TD></TD></TR>\n"
					output << "</TABLE>\n\n"
				end
				output << "<P></P>\n"
			end
		end
		return output

	end
end

