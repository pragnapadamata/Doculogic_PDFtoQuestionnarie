import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";

interface FileInfo {
  userId: string;
  fileUrl: string;
  status: string;
  filename: string;
  filetype: string;
  id: string;
  createdDate: string;
}

interface ChatMessage {
  sender: "user" | "bot";
  content: string;
}

function App() {
  const [file, setFile] = useState(null);
  const [files, setFiles] = useState([]);
  const [selected, selectFile] = useState("");
  const [chatMessages, setChatMessages] = useState([]);
  const [chatInput, setChatInput] = useState("");

  useEffect(() => {
    const userId = localStorage.getItem("userId");
    if (userId) {
      fetchFiles(userId);
    }
  }, []);

  const handleFileChange = (event) => {
    if (event.target.files && event.target.files.length > 0) {
      setFile(event.target.files[0]);
    }
  };

  const handleFileUpload = async () => {
    if (file) {
      const userId = localStorage.getItem("userId");
      if (!userId) {
        console.error("User ID not found in localStorage");
        return;
      }

      const formData = new FormData();
      formData.append("file", file);
      formData.append("userid", userId);

      console.log("sending");

      try {
        const response = await fetch("http://localhost:9000/file/upload", {
          method: "POST",
          body: formData,
        });

        if (response.ok) {
          const data = await response.json();
          console.log(data);
          setFiles(prevFiles => [...prevFiles, data.data.fileUrl]);
          console.log("File uploaded successfully");
        } else {
          console.error("Error uploading file");
        }
      } catch (error) {
        console.error("Error uploading file:", error);
      }
    }
  };

  const fetchFiles = async (userId) => {
    try {
      const response = await fetch(`http://localhost:9000/user/${userId}`);
      if (response.ok) {
        const data = await response.json();
        console.log(data);
        setFiles(data.data);
      } else {
        console.error("Error fetching files");
      }
    } catch (error) {
      console.error("Error fetching files:", error);
    }
  };

  const selectFiles = (fileId) => {
    selectFile(fileId);
    setChatMessages([]);
  };

  const handleFileDelete = async (fileId) => {
    const userId = localStorage.getItem("userId");
    if (!userId) {
      console.error("User ID not found in localStorage");
      return;
    }

    try {
      const response = await fetch(`http://localhost:9000/user/${userId}/${fileId}`, {
        method: "DELETE",
      });

      if (response.ok) {
        setFiles(prevFiles => prevFiles.filter(file => file.id !== fileId));
        console.log("File deleted successfully");
      } else {
        console.error("Error deleting file");
      }
    } catch (error) {
      console.error("Error deleting file:", error);
    }
  };

  const handleFileOpen = (fileUrl) => {
    window.open(fileUrl, "_blank");
  };

  const handleChatInputChange = (event) => {
    setChatInput(event.target.value);
  };

  const handleChatSubmit = async () => {
    if (selected && chatInput.trim() !== "") {
      setChatMessages(prevMessages => [
        ...prevMessages,
        { sender: "user", content: chatInput },
      ]);

      try {
        const response = await fetch("http://127.0.0.1:5000/qa", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ question: chatInput, fileId: selected }),
        });

        if (response.ok) {
          const data = await response.json();
          console.log(data);
          let message = "";
          for(const ms of data.answer.response){
            if(ms["done"]===false){
              message+=ms["response"]
            }
          }
          setChatMessages(prevMessages => [
            ...prevMessages,
            { sender: "bot", content: message },
          ]);
        } else {
          console.error("Error getting response from bot");
        }
      } catch (error) {
        console.error("Error sending message to bot:", error);
      }

      setChatInput("");
    }
  };

  return (
    <div className="fixed top-0 left-0 w-full h-full bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex">
      <div className="w-full h-full p-10">
        <div className="absolute top-4 left-4 text-white">
          <h1 className="text-2xl font-bold bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
            DocuLogic
          </h1>
          <p className="text-xs text-gray-400 mt-1">
            Built by Pragna Padamata & Joshitha Kosaraju | BVRIIT Hyderabad College
          </p>
        </div>
        <div className="h-[30%] flex items-center justify-center">
          <div className="text-center">
            <label className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 rounded-lg px-6 py-3 cursor-pointer text-white font-medium transition-all duration-200 shadow-lg hover:shadow-xl">
              <input
                type="file"
                className="hidden"
                onChange={handleFileChange}
              />
              📄 Choose Document
            </label>
            <Button
              className="ml-4 bg-white/10 border-white/20 text-white hover:bg-white/20 transition-all duration-200"
              onClick={handleFileUpload}
              disabled={!file}
            >
              ⬆️ Upload
            </Button>
            {file && (
              <p className="text-white/70 text-sm mt-2">
                Selected: {file.name}
              </p>
            )}
          </div>
        </div>
        <div className="w-full h-full overflow-auto text-white">
          <h2 className="text-lg font-semibold mb-4 text-white/90">📁 Your Documents</h2>
          {files.length > 0 ? (
            <div className="space-y-2">
              {files.map(file => (
                <div
                  key={file.id}
                  className={`w-full h-fit flex justify-between items-center rounded-lg p-3 transition-all duration-200 ${
                    file.id === selected 
                      ? "bg-gradient-to-r from-purple-800/50 to-blue-800/50 border border-purple-500/30 shadow-lg" 
                      : "bg-white/5 hover:bg-white/10 border border-white/10"
                  }`}
                >
                  <div className="flex-1 text-sm text-white/80 truncate">
                    📄 {file.filename}
                  </div>
                  <div className="flex items-center gap-2 ml-4">
                    <Button
                      className="bg-white/10 border-white/20 text-white hover:bg-white/20 text-xs px-3 py-1 h-8"
                      onClick={() => handleFileOpen(file.fileUrl)}
                    >
                      👁️ Open
                    </Button>
                    <Button
                      className="bg-white/10 border-white/20 text-white hover:bg-white/20 text-xs px-3 py-1 h-8"
                      onClick={() => selectFiles(file.id)}
                    >
                      ✅ Select
                    </Button>
                    <Button 
                      className="text-xs px-3 py-1 h-8 bg-red-500/20 border-red-500/30 hover:bg-red-500/30"
                      onClick={() => handleFileDelete(file.id)}
                    >
                      🗑️ Delete
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="text-center py-8 text-white/50">
              <div className="text-4xl mb-2">📂</div>
              <p>No documents uploaded yet.</p>
              <p className="text-sm">Upload your first document to get started!</p>
            </div>
          )}
        </div>
      </div>
      <div className="w-full rounded-3xl border border-white/10 m-10 flex flex-col items-center justify-between p-6 bg-white/5 backdrop-blur-sm shadow-2xl">
        <div className="w-full mb-4">
          <h3 className="text-lg font-semibold text-white/90 mb-2">💬 AI Assistant</h3>
          <p className="text-sm text-white/60">Ask questions about your documents</p>
        </div>
        <div className="h-[70%] w-full">
          {selected ? (
            <ScrollArea className="h-full w-full">
              {chatMessages.map((message, index) => (
                <div
                  key={index}
                  className={`flex mb-4 ${
                    message.sender === "user" ? "justify-end" : "justify-start"
                  }`}
                >
                  <div className={`max-w-[70%] p-3 rounded-2xl ${
                    message.sender === "user" 
                      ? "bg-gradient-to-r from-blue-600 to-purple-600 text-white ml-auto" 
                      : "bg-white/10 text-white border border-white/20"
                  }`}>
                    <div className="flex items-center mb-1">
                      <span className="text-xs opacity-70">
                        {message.sender === "user" ? "👤 You" : "🤖 DocuLogic"}
                      </span>
                    </div>
                    <p className="text-sm leading-relaxed">{message.content}</p>
                  </div>
                </div>
              ))}
            </ScrollArea>
          ) : (
            <div className="h-full w-full flex flex-col items-center justify-center text-white/50">
              <div className="text-6xl mb-4">💭</div>
              <p className="text-lg font-medium mb-2">Ready to chat!</p>
              <p className="text-sm">Select a document to start asking questions</p>
            </div>
          )}
        </div>
        <div className="w-full flex items-center gap-2 p-3 bg-white/5 rounded-xl border border-white/10">
          <input
            className="flex-1 bg-transparent border-none text-white placeholder-white/50 focus:ring-0"
            placeholder="Ask anything about your document..."
            value={chatInput}
            onChange={handleChatInputChange}
            onKeyPress={(e) => e.key === 'Enter' && handleChatSubmit()}
          />
          <Button 
            className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white border-0 px-4 py-2"
            onClick={handleChatSubmit}
            disabled={!chatInput.trim() || !selected}
          >
            📤 Send
          </Button>
        </div>
      </div>
    </div>
  );
}

export default App;
