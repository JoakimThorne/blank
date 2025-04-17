import Link from "next/link"

export default function Hero() {
  return (
    <section className="relative flex items-center justify-center h-screen bg-gradient-to-b from-[#10232a] to-[#3d4d55]">
      <div className="text-center px-4">
        <h1 className="text-5xl md:text-6xl font-bold text-[#d3c3b9]">
          Welcome to the Admin Panel
        </h1>
        <p className="mt-4 text-lg text-[#a79e9c] max-w-2xl mx-auto">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus
          lacinia odio vitae vestibulum vestibulum.
        </p>
        <Link
          href="#"
          className="inline-block mt-8 px-6 py-3 bg-[#b58863] text-[#10232a] rounded-md font-semibold hover:opacity-90 transition shadow-lg"
        >
          Get Started
        </Link>
      </div>
    </section>
  )
}