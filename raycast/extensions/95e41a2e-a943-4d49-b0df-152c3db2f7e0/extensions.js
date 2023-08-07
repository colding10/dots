"use strict";var $=Object.create;var E=Object.defineProperty;var M=Object.getOwnPropertyDescriptor;var X=Object.getOwnPropertyNames;var j=Object.getPrototypeOf,_=Object.prototype.hasOwnProperty;var q=(e,n)=>{for(var o in n)E(e,o,{get:n[o],enumerable:!0})},O=(e,n,o,l)=>{if(n&&typeof n=="object"||typeof n=="function")for(let a of X(n))!_.call(e,a)&&a!==o&&E(e,a,{get:()=>n[a],enumerable:!(l=M(n,a))||l.enumerable});return e};var y=(e,n,o)=>(o=e!=null?$(j(e)):{},O(n||!e||!e.__esModule?E(o,"default",{value:e,enumerable:!0}):o,e)),H=e=>O(E({},"__esModule",{value:!0}),e);var te={};q(te,{default:()=>V,useLocalExtensions:()=>W});module.exports=H(te);var r=require("@raycast/api"),m=require("react");var Y=require("@raycast/api"),w=y(require("fs"));var h=y(require("fs/promises")),N=y(require("os")),u=y(require("path")),F=y(require("child_process")),P=require("@raycast/api");function K(e){if(!e)return e;let n=e.match(/%(.+)%/);if(n)return n[1]}function z(){return`/Applications/${Q()}.app/Contents/Resources/app/bin/code`}var C=class{constructor(n){this.cliFilename=n}installExtensionByIDSync(n){F.execFileSync(this.cliFilename,["--install-extension",n,"--force"])}uninstallExtensionByIDSync(n){F.execFileSync(this.cliFilename,["--uninstall-extension",n,"--force"])}};function R(){return new C(z())}async function G(e){try{if(await S(e)){let n=await h.readFile(e,{encoding:"utf-8"}),o=JSON.parse(n),l=o.displayName,a=K(l),i=o.icon,c=u.default.dirname(e);if(a&&a.length>0){let d=u.default.join(c,"package.nls.json");try{if(await S(d)){let x=await h.readFile(d,{encoding:"utf-8"}),D=JSON.parse(x)[a];D&&D.length>0&&(l=D)}}catch{}}let p=o.preview,f=i?u.default.join(c,i):void 0;return{displayName:l,icon:f,preview:p}}}catch{}}async function B(){let e=u.default.join(N.homedir(),`.${I()}/extensions`),n=u.default.join(e,"extensions.json");if(await S(n)){let o=await h.readFile(n,{encoding:"utf-8"}),l=JSON.parse(o);if(l&&l.length>0){let a=[];for(let i of l){let c=typeof i.location=="string"?u.default.join(e,i.location):i.location.fsPath??i.location.path,p=u.default.join(c,"package.json"),f=await G(p);a.push({id:i.identifier.id,name:f?.displayName||i.identifier.id,version:i.version,preRelease:i.metadata?.preRelease,icon:f?.icon,updated:i.metadata?.updated,fsPath:c,publisherId:i.metadata.publisherId,publisherDisplayName:i.metadata.publisherDisplayName,preview:f?.preview,installedTimestamp:i.metadata?.installedTimestamp})}return a}}}function v(){return(0,P.getPreferenceValues)().build}var A={Code:"vscode","Code - Insiders":"vscode-insiders"};function I(){let e=A[v()];return!e||e.length<=0?A.Code:e}var L={Code:"Visual Studio Code","Code - Insiders":"Visual Studio Code - Insiders"};function Q(){let e=L[v()];return!e||e.length<=0?L.Code:e}function k(e){return e instanceof Error?e.message:"unknown error"}async function S(e){return w.promises.access(e,w.constants.F_OK).then(()=>!0).catch(()=>!1)}var ae=new Intl.NumberFormat("en",{notation:"compact"});var t=require("@raycast/api");var b=require("react/jsx-runtime");function T(e){return(0,b.jsx)(t.Action,{onAction:async()=>{try{await(0,t.confirmAlert)({title:"Uninstall Extension?",icon:{source:t.Icon.Trash,tintColor:t.Color.Red},primaryAction:{style:t.Alert.ActionStyle.Destructive,title:"Uninstall"}})&&(await(0,t.showToast)({style:t.Toast.Style.Animated,title:"Install Extension"}),R().uninstallExtensionByIDSync(e.extensionID),await(0,t.showToast)({style:t.Toast.Style.Success,title:"Uninstall Successful"}),e.afterUninstall&&e.afterUninstall())}catch(o){(0,t.showToast)({style:t.Toast.Style.Failure,title:"Error",message:k(o)})}},title:"Uninstall Extension",icon:{source:t.Icon.Trash,tintColor:t.Color.Red}})}function U(e){return(0,b.jsx)(t.Action.OpenInBrowser,{title:"Open in VSCode",url:`${I()}:extension/${e.extensionID}`,icon:"icon.png",onOpen:n=>{(0,t.showHUD)("Open VSCode Extension"),e.onOpen&&e.onOpen(n)}})}function J(e){let n=`https://marketplace.visualstudio.com/items?itemName=${e.extensionID}`;return(0,b.jsx)(t.Action.OpenInBrowser,{title:"Open in Browser",url:n,shortcut:{modifiers:["cmd"],key:"b"},onOpen:()=>{(0,t.showHUD)("Open VSCode Extension in Browser")}})}var s=require("react/jsx-runtime");function Z(e){return(0,s.jsx)(U,{extensionID:e.extension.id})}function ee(e){return(0,s.jsx)(J,{extensionID:e.extension.id})}function ne(e){let n=e.extension;return(0,s.jsx)(r.List.Item,{title:n.name,subtitle:n.publisherDisplayName,icon:{source:n.icon||"icon.png",fallback:"icon.png"},accessories:[{tag:n.preview===!0?{color:r.Color.Red,value:"Preview"}:""},{tag:n.version,tooltip:n.installedTimestamp?`Installed:  ${new Date(n.installedTimestamp).toLocaleString()}`:""}],actions:(0,s.jsxs)(r.ActionPanel,{children:[(0,s.jsxs)(r.ActionPanel.Section,{children:[(0,s.jsx)(Z,{extension:n}),(0,s.jsx)(ee,{extension:n})]}),(0,s.jsxs)(r.ActionPanel.Section,{children:[(0,s.jsx)(r.Action.CopyToClipboard,{content:n.id,title:"Copy Extension ID",shortcut:{modifiers:["cmd","shift"],key:"."}}),(0,s.jsx)(r.Action.CopyToClipboard,{content:n.publisherDisplayName,title:"Copy Publisher Name",shortcut:{modifiers:["cmd","shift"],key:","}}),(0,s.jsx)(r.Action.Open,{title:"Open in Finder",target:n.fsPath,shortcut:{modifiers:["cmd","shift"],key:"f"}})]}),(0,s.jsx)(r.ActionPanel.Section,{children:(0,s.jsx)(T,{extensionID:n.id,afterUninstall:e.reloadExtension})})]})})}function V(){let{extensions:e,isLoading:n,error:o,refresh:l}=W();o&&(0,r.showToast)({style:r.Toast.Style.Failure,title:"Error",message:o});let a=e?.sort((i,c)=>i.name<c.name?-1:i.name>c.name?1:0);return(0,s.jsx)(r.List,{isLoading:n,searchBarPlaceholder:"Search Installed Extensions",children:(0,s.jsx)(r.List.Section,{title:"Installed Extensions",subtitle:`${a?.length}`,children:a?.map(i=>(0,s.jsx)(ne,{extension:i,reloadExtension:l},i.id))})})}function W(){let[e,n]=(0,m.useState)(!0),[o,l]=(0,m.useState)(),[a,i]=(0,m.useState)(),[c,p]=(0,m.useState)(new Date),f=()=>{p(new Date)};return(0,m.useEffect)(()=>{let d=!1;async function x(){if(!d){n(!0),i(void 0);try{let g=await B();d||l(g)}catch(g){d||i(k(g))}finally{d||n(!1)}}}return x(),()=>{d=!0}},[c]),{extensions:o,isLoading:e,error:a,refresh:f}}0&&(module.exports={useLocalExtensions});