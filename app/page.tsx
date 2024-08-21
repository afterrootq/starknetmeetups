
export default function Home() {
    return (
        <main className="items-center min-h-screen p-24 flex justify-center ">
            <div className="flex flex-col items-center text-center gap-6">
                <img src="/favicon.png" alt="StarknetMeetups Logo" className="h-30 w-auto fill-current" />
                <h1 className="text-4xl font-bold mb-4">StarknetMeetups</h1>
                <hr className="w-full border-gray-300 mb-4" />
                <div className="flex flex-col md:flex-row gap-4">
                    <a className="bg-blue-400 hover:bg-blue-700 text-white py-2 px-4 rounded" href="/new">
                        New Event
                    </a>
                </div>
            </div>
        </main>
    )
}
