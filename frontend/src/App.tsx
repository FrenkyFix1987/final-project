import { useState } from "react";
import { createUser } from "./api";

export default function App() {
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");

  const submit = async () => {
    await createUser(email, name);
    alert("User created");
  };

  return (
    <div style={{ padding: 40 }}>
      <h1>Create User</h1>

      <input
        placeholder="Email"
        value={email}
        onChange={e => setEmail(e.target.value)}
      />

      <br />

      <input
        placeholder="Name"
        value={name}
        onChange={e => setName(e.target.value)}
      />

      <br />

      <button onClick={submit}>Submit</button>
    </div>
  );
}
