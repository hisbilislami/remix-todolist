import type { MetaFunction } from "@remix-run/node";
import { Theme, useTheme } from "~/utils/theme-provider";

export const meta: MetaFunction = () => {
  return [
    { title: "Todo list" },
    { name: "Todo list app created by hisbil", content: "Bill Todo List!" },
  ];
};

export default function Index() {
  const [, setTheme] = useTheme();

  const toggleTheme = () => {
    setTheme((prevTheme) =>
      prevTheme === Theme.LIGHT ? Theme.DARK : Theme.LIGHT
    );
  };

  return (
    <div className="flex h-screen items-center justify-center">
      <button onClick={toggleTheme}>Toggle</button>
    </div>
  );
}
