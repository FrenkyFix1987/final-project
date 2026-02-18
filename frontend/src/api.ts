const API_URL = "/api";

export async function createUser(email: string, name: string) {
  const res = await fetch(`${API_URL}/users/`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({ email, name })
  });

  if (!res.ok) {
    throw new Error("Failed to create user");
  }

  return res.json();
}
